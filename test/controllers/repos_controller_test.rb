require "test_helper"

describe ReposController do
  it "should get index" do
    get repos_index_url
    value(response).must_be :success?
  end

end
