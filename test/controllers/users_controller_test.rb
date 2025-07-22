require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_url
    assert_response :success
    assert_select "h1", "Join MessageMe"
  end

  test "should create user with valid attributes" do
    assert_difference("User.count", 1) do
      post signup_url, params: { 
        user: { 
          username: "testuser", 
          password: "password123", 
          password_confirmation: "password123" 
        } 
      }
    end
    
    assert_redirected_to root_url
    assert_equal "Account created successfully! Welcome to MessageMe, testuser!", flash[:notice]
    
    # Check if user is logged in
    follow_redirect!
    assert_response :success
  end

  test "should not create user with invalid attributes" do
    assert_no_difference("User.count") do
      post signup_url, params: { 
        user: { 
          username: "", 
          password: "123", 
          password_confirmation: "456" 
        } 
      }
    end
    
    assert_response :success
    assert_select ".text-red-600"
  end

  test "should not create user with duplicate username" do
    # Create a user first
    User.create!(username: "testuser", password: "password123", password_confirmation: "password123")
    
    assert_no_difference("User.count") do
      post signup_url, params: { 
        user: { 
          username: "testuser", 
          password: "password123", 
          password_confirmation: "password123" 
        } 
      }
    end
    
    assert_response :success
    assert_select ".text-red-600"
  end

  test "should redirect to root if already logged in" do
    user = User.create!(username: "testuser", password: "password123", password_confirmation: "password123")
    
    # Log in the user
    post login_url, params: { session: { username: "testuser", password: "password123" } }
    
    # Try to access signup page
    get signup_url
    assert_redirected_to root_url
    assert_equal "You are already logged in.", flash[:alert]
  end
end
