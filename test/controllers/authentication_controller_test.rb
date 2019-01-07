require "test_helper"

describe AuthenticationController do
  it "should get github" do
    get authentication_github_url
    value(response).must_be :success?
  end

end
