require "test_helper"

describe User do
  let(:user) { users(:one) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it "is invalid without a login, email, or name" do
    [:name, :email, :login].each do |field|
      user = users(:one)
      user[field] = nil
      expect(user.valid?).must_equal false
    end
  end

end
