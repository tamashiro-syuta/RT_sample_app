require 'test_helper'

# integration = 統合
class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:michael)
  end
  
  # レイアウトのリンクに対するテスト
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    # 下の例だと、生成されたviewに　<a href="/about">...</a>　のコードがないかを判定している
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    
    # test環境でfull_titleヘルパーを使う
    get contact_path
    assert_select "title", full_title("Contact")
    
    get signup_path
    assert_select "title", full_title("Sign up")
  end
  
  test "layout links when loged in" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
  
  
  test "layout links when logged in user" do
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    # フォローしている人数が表示されているか
    assert_match @user.active_relationships.count.to_s, response.body
    # フォロワーの人数が表示されているか
    assert_match @user.passive_relationships.count.to_s, response.body
  end
  
end
