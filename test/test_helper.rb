ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# クラウドIDEを含む多くのシステムで red や green の表示が見やすくなる
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # テストユーザーがログイン中の場合にtrueを返す
  # current_userメソッドは、テストコードから呼び出せないので独自に関数を定義
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # テストユーザーとしてログインする
  # (上下の同名のメソッドで、単体テストでも統合テストでも違いを意識する必要なく、テストできる)
  def log_in_as(user)
    session[:user_id] = user.id
  end
  
  # test環境でもApplicationヘルパーを使えるようにする(class部分にTestCaseと記載されている)
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  # (上下の同名のメソッドで、単体テストでも統合テストでも違いを意識する必要なく、テストできる)
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end