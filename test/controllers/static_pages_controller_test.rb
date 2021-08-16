require 'test_helper'

# アクションをgetして正常に動作することを確認しているテスト
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get root" do
    get root_url
    assert_response :success
  end
  
  test "should get home" do
    # Homeページのテスト。GETリクエストをhomeアクションに対して発行（=送信）せよ。そうすれば、リクエストに対するレスポンスは［成功］になるはず
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end
  
  # aboutアクションで、ちゃんとページが開くかのテスト
  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end
  
  test "should get contact" do
    # aboutのURLにGETリクエストを送信
    get static_pages_contact_url
    # サクセスのレスポンスが帰ってきたら成功！！
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end

end
