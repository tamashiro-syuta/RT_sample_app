class ApplicationController < ActionController::Base
  # セッションのヘルパーモジュールを読み込む(どこでもセッションヘルパーメソッドが使える)
  include SessionsHelper
  
  def hello
    render html: "hello, world!"
  end
end
