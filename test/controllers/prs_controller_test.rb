require "test_helper"

describe PrsController do
  it "should get index" do
    get prs_index_url
    value(response).must_be :success?
  end

end
