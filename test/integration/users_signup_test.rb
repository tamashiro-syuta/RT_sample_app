require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    # 平行してテストが行われた際、データが混同しないようにリセットしている
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    # signup_pathにアクセス
    get signup_path
    # 以下は、テスト前後でユーザーの数が変わらないかをテストしている
    assert_no_difference 'User.count' do
      # users_pathに対して以下のparamsを送信
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    # https://qiita.com/shumpeism/items/06332cb4ced1c15cb09c (assert_selectの使い方)
    assert_select 'div#error_explanation'     # 1. id="error_explanationが存在するか
    assert_select 'div.alert'                            # 2.1. class="alert"が存在するか
    assert_select 'div.alert-danger'              # 2.2. class="alert-danger"が存在するか
  end
  
  # 有効なユーザー登録に対するテスト
  test "valid signup information with account activation" do
    get signup_path
    # テスト前とテスト後のユーザー数の差が１
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    
    # 配信されたメッセージがきっかり1つであるか確認
    assert_equal 1, ActionMailer::Base.deliveries.size
    # assignsメソッドで、インスタンス変数をテスト内でも使用することができる
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not is_logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド
    follow_redirect!
    assert_template 'users/show'
    # ユーザーがログインしているか判定
    assert is_logged_in?
    #フラッシュがnilなら失敗、そうでないなら成功になる
    assert_not flash.empty?
  end
  
end