require "test_helper"

describe ClassesController do
  it "should get index" do
    get classes_index_url
    value(response).must_be :success?
  end

end
