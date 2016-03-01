class LoginTest < ActionDispatch::IntegrationTest
  test "visitor can see login link" do
    visit root_path

    assert page.has_content?("Sign In")
    assert page.has_content?("Sign Up")
  end

  test "visitor can create account and sign in" do
    visit root_path

    click_link "Sign Up"

    fill_in "Email", with: "emily@emilydowdle.com"
    fill_in "Password", with: "password"
    fill_in "Confirm password", with: "password"
    click_button "Create Account"

    assert_equal '/', current_path

  end

  test "user can login" do
    skip
    User.create(username: "Jon",
                password: "password")

    visit root_path

    click_link "Login"
    fill_in "Username", with: "Jon"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal root_path, current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

end
