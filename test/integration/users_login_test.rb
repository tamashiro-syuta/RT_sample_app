require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  # fixtureのusers.ymlのテスト用サンプルデータをインスタンス変数化
  def setup
    @user = users(:michael)
  end
  
  # 無効な情報でログイン
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  # メールアドレスが正しくてパスワードが誤っている場合
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  # 有効な情報でログイン
  test "login with valid information followed by logout" do
    get login_path
    # テスト用ユーザーのパスワードを'password'と設定するのはよくやる手法
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    # ログインしてるか確認
    assert is_logged_in?
    # リダイレクト先が正しいかチェック
    assert_redirected_to @user
    # 実際にリダイレクト先に遷移し
    follow_redirect!
    assert_template 'users/show'
    # ログインパスがログインパスが無いか（0個か）を判定
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    # ログアウトの実行と検証
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
end
