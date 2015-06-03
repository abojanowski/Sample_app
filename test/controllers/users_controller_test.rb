require 'test_helper'

class UsersControllerTest < ActionController::TestCase

	def setup
		@user = 		  users(:michael)
		@other_user = users(:archer)
	end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
  	get :index
  	assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as 
  non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
 end
