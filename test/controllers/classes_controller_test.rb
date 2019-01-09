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

  describe "create" do
    it "can create a classroom" do
      expect {
        post classes_path, headers: headers, 
          params: {
            classroom: {
              cohort_number: 27,
              name: 'testing'
            }
          }
        }.must_change 'Classroom.count', 1

      new_classroom = Classroom.find_by(cohort_number: 27)
      
      expect(new_classroom.cohort_number).must_equal 27
      expect(new_classroom.name).must_equal 'testing'
      must_respond_with :success
    end

    it "will respond with unauthorized if the token is missing or wrong" do

      expect {
        post classes_path, headers: invalid_header, 
          params: {
            classroom: {
              cohort_number: 27,
              name: 'testing'
            }
          }
      }.wont_change 'Classroom.count'

      new_classroom = Classroom.find_by(cohort_number: 27)
      body = JSON.parse(response.body)

      must_respond_with :unauthorized
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'You are not authorized to access this page.'
      expect(new_classroom).must_be_nil
    end

    it "will respond with unauthorized if the user doesn't have the right to edit it" do

      expect {
        post classes_path, headers: nonadmin_header, 
          params: {
            classroom: {
              cohort_number: 27,
              name: 'testing'
            }
          }
      }.wont_change 'Classroom.count'

      new_classroom = Classroom.find_by(cohort_number: 27)
      body = JSON.parse(response.body)

      must_respond_with :unauthorized
      expect(response.header['Content-Type']).must_include 'json'
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'You are not authorized to access this page.'
      expect(new_classroom).must_be_nil
    end
  end

  describe "destroy classes" do
    it "can destroy a classroom" do
      nodes = classrooms(:nodes)
      expect {
        delete class_path(nodes.id), headers: headers
      }.must_change 'Classroom.count', -1

      deleted_classroom = Classroom.find_by(id: nodes.id)
      
      expect(deleted_classroom).must_be_nil
      must_respond_with :success
    end

    it "can't destroy a classroom with a nonadmin user" do
      nodes = classrooms(:nodes)
      expect {
        delete class_path(nodes.id), headers: nonadmin_header
      }.wont_change 'Classroom.count'

      must_respond_with :unauthorized
    end

    it "can't destroy a classroom with an invalid token" do
      nodes = classrooms(:nodes)
      expect {
        delete class_path(nodes.id), headers: invalid_header
      }.wont_change 'Classroom.count'

      must_respond_with :unauthorized
    end
  end
end
