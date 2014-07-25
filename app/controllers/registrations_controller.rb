class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :middle_name, :last_name,
                                :date_of_birth, :email, :password, :ssn)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :middle_name, :last_name,
                                :date_of_birth, :email, :password, :ssn)
  end
end
