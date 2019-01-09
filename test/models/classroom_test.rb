require "test_helper"

describe Classroom do
  let(:classroom) { classrooms(:nodes) }

  it "must be valid" do
    value(classroom).must_be :valid?
  end

  it "is not valid without a cohort number or name" do
    [:name, :cohort_number].each do |field|
      classroom = classrooms(:nodes)
      classroom[field] = nil
      expect(classroom).wont_be :valid?
    end
  end


end
