require "test_helper"

describe StudentSubmission do
  let(:student_submission) { StudentSubmission.new }

  it "must be valid" do
    value(student_submission).must_be :valid?
  end
end
