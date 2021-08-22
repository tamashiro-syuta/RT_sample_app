class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    #ターミナル上でデバッグを試すには、以下を入れる
    # debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # 実装は終わっていないことに注意!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # 保存の成功をここで扱う。
       redirect_to @user # redirect_to user_url(@user) と同じ
    else
      render 'new'
    end
  end
  
  #この記述をすることで、それ以下の記述が(user_paramsなど)外部で使えないようになる
  #Strong Parametersを使う際には、このように設定することが慣習になっている
  private 
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end
