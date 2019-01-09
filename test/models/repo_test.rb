require "test_helper"

describe Repo do
  let(:repo) { repos(:inspiration_board) }

  it "must be valid" do
    value(repo).must_be :valid?
  end

  it "is invalid without a url or nil individual" do
    [:repo_url, :individual].each do |field|
      repo = repos(:inspiration_board)
      repo[field] = nil
      expect(repo).wont_be :valid?
    end
  end
end
