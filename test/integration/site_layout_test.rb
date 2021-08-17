require 'test_helper'

# integration = 統合
class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
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
  
end
