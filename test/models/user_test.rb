require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do 
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid? 
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  test "name should no be too short" do
    @user.name = ("a" * 51)
    assert_not @user.valid?
  end 

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid adress" do
    valid_adresses =  %w[user@example.com USER@foo.COM 
      A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_adresses.each do |valid_adress|
      @user.email = valid_adress
      assert @user.valid?, "#{valid_adress.inspect} should be valid"
    end     
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum 6 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    # assert_not 
  end  
end