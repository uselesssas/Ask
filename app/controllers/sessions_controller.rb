class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[destroy]

  def new; end

  def create
    # render plain: params.to_yaml and return
    # Находим пользователя по email
    user = User.find_by email: params[:email]
    # Если пользователь не ввёл email
    # user будет nil
    # знак & защищает и if будет false
    if user&.authenticate(params[:password])
      sign_in(user)
      remember(user) if params[:remember_me] == '1'
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      flash.now[:warning] = 'Incorrect email and/or password!'
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = 'See you later!'
    redirect_to root_path
  end
end
