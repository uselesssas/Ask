class SessionsController < ApplicationController
  def new; end

  def create
    # render plain: params.to_yaml
    user = User.find_by email: params[:email]
    # Если пользователь не ввёл email
    # user будет nil
    # знак & защищает и if будет false
    if user&.authenticate(params[:password])
      sign_in(user)
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      flash.now[:warning] = 'Incorrect email and/or password!'
      render :new
    end
  end

  def destroy; end
end
