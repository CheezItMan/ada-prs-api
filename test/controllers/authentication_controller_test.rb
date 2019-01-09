require "test_helper"

describe AuthenticationController do
  it "should get github login link" do
    VCR.use_cassette("login") do
      token = "12f434baedacdb08f217"
      get auth_github_path, params: { code: token }
      response_location = response.location

      expect(response_location.include? "token=").must_equal true
      must_respond_with :redirect
    end    
  end

  it "will give an error message for a failed token" do
    VCR.use_cassette("login") do
      token = "bogus"
      get auth_github_path, params: { token: token }

      response_location = response.location

      must_respond_with :redirect
      expect(response_location.include? "error=").must_equal true
    end
  end

end
