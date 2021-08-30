class ApplicationController < ActionController::Base
  # セッションのヘルパーモジュールを読み込む(どこでもセッションヘルパーメソッドが使える)
  include SessionsHelper
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
