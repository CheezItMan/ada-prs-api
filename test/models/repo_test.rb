require "test_helper"

describe Repo do
  let(:repo) { Repo.new }

  it "must be valid" do
    value(repo).must_be :valid?
  end
end
