require "test_helper"

describe UsersController do
  it "should get index" do
    get users_index_url
    value(response).must_be :success?
  end

end
