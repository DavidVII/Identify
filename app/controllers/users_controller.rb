class UsersController < ApplicationController
  def verify_user
    @user = User.find(params[:id])
    address_details = { address: request.params[:user][:address] }

    @user.verify(@user, address_details, params[:user][:ssn])
    @user.save

    if @user.verified?
      redirect_to questionnaire_path
    else
      flash[:alert] = "You were not verified with those details"
    end
  end
end
