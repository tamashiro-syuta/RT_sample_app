class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    
    # ユーザーがデータベースにあり、かつ(&&)、認証に成功した場合にのみ
    # 下は 「if user && user.authenticate(params[:session][:password])」と等価
    if @user && @user.authenticate(params[:session][:password])
      # 有効でないとログインできない仕様
      if @user.activated?
        # ユーザーログイン後にユーザー情報のページにリダイレクトする
        log_in @user
        # paramsによって送られてきたチェックボックスの結果によってrememberにするかforgetにするか判定
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    #複数のブラウザで開いてた場合に起きる二重にログアウトできてしまうエラーを防ぐため
    #ログイン中にしかログアウトできなくする
    log_out if logged_in?
    redirect_to root_url
  end
  
end
