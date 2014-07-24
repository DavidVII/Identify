class UsersController < ApplicationController
  def verify_user
    @user = User.find(params[:id])
    @user.verify

    if @user.verified?
      flash[:success] = request.params
      redirect_to unverified_path
    end
  end
end
