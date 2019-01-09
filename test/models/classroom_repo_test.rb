require "test_helper"

describe ClassroomRepo do
  let(:classroom_repo) { ClassroomRepo.new }

  it "must be valid" do
    value(classroom_repo).must_be :valid?
  end
end
