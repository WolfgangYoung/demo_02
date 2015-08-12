require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
	@user = User.new(name: "lc", email: "lc@qq.com",
                   password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
	assert @user.valid?
  end

  test "name should be present" do
	@user.name = "  "
	assert_not @user.valid?
  end

  test "name should not be too long" do
	@user.name = "a" * 51
	assert_not @user.valid?
  end

  test "email should not be too long" do
	@user.email = "a" * 256
	assert_not @user.valid?
  end

  test "email validation should accept valid adderss" do
	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org]
	valid_addresses.each do |valid_address|
	  @user.email = valid_address
	  assert @user.valid?, "#{valid_address.inspect} should be valid"
	end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert @user.valid?
  end
  # test "the truth" do
  #   assert true
  # end
end
