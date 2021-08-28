module SessionsHelper
  
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    # 永続セッションのためにユーザーをデータベースに記憶する
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    # session[:user_id]が存在してたら（ログインしてたら）
    if (user_id = session[:user_id])
      #ログイン中のユーザーを返す
      @current_user ||= User.find_by(id: user_id)
    #cookieが存在してたら
    elsif (user_id = cookies.signed[:user_id])
      #そのcookieに該当するユーザーを変数に入れる
      user = User.find_by(id: user_id)
      #上で変数化したユーザーが存在して、かつそのユーザーのトークンがダイジェストと一致したら
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        #ログインして@current_userに返す
        @current_user = user
      end
    end
  end
  
  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 記憶したURL（もしくはデフォルト値）にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
