require "test_helper"

describe ClassesController do
  let (:user) { users(:one) }
  let (:nonadmin_user) { users(:two) }
  let (:headers) { 
    token = JsonWebToken.encode(user.login)
    { 'authorization' => token }
  }
  let (:invalid_header) {
    token = JsonWebToken.encode('blah')
    { 'authorization' => token }
  }
  let (:nonadmin_header) {
    token = JsonWebToken.encode(nonadmin_user.login)
    { 'authorization' => token }
  }
  describe "index" do 
    it "should get index" do
      token = JsonWebToken.encode(user.login)
      get classes_path, headers: headers
      
      body = JSON.parse(response.body)

      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal true
      expect(body['classes'].length).must_equal Classroom.count
    end

    it "should respond with unauthorized without the token" do
      get classes_path

      body = JSON.parse(response.body)

      must_respond_with :unauthorized
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'You are not authorized to access this page.'
    end
  end

  describe "update" do
    it "can update a classroom" do
      patch class_path(classrooms(:nodes).id), headers: headers, 
        params: {
          classroom: {
            cohort_number: 27,
            name: 'testing'
          }
        }

      changed_classroom = classrooms(:nodes).reload
      
      expect(changed_classroom.cohort_number).must_equal 27
      expect(changed_classroom.name).must_equal 'testing'
      must_respond_with :success
    end

    it "will respond with unauthorized if the token is missing or wrong" do
      patch class_path(classrooms(:nodes).id), headers: invalid_header, 
        params: {
          classroom: {
            cohort_number: 27,
            name: 'testing'
          }
        }

      changed_classroom = classrooms(:nodes).reload
      body = JSON.parse(response.body)

      must_respond_with :unauthorized
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'You are not authorized to access this page.'
      expect(changed_classroom.cohort_number).wont_equal 27
      expect(changed_classroom.name).wont_equal 'testing'
    end

    it "will respond with unauthorized if the user doesn't have the right to edit it" do
      patch class_path(classrooms(:nodes).id), headers: nonadmin_header, 
        params: {
          classroom: {
            cohort_number: 27,
            name: 'testing'
          }
        }

      changed_classroom = classrooms(:nodes).reload
      body = JSON.parse(response.body)

      must_respond_with :unauthorized
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'You are not authorized to access this page.'
      expect(changed_classroom.cohort_number).wont_equal 27
      expect(changed_classroom.name).wont_equal 'testing'
    end
  end
end
