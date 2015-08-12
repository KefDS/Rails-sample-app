require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout link" do
    # root page
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path

    user = users(:user_example)
    log_in_as(user)
    get root_path

    assert_select "a[href=?]", users_path           # Index
    assert_select "a[href=?]", users_path           # Show
    assert_select "a[href=?]", edit_user_path(user) # Edit
    assert_select "a[href=?]", logout_path
  end
end
