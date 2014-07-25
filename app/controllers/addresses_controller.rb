class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @address = Address.new
  end

  def create
    @user = current_user
    @address = @user.build_address(address_params)
    @address.user_id = @user.id

    if @address.save
      verify_user

      flash[:success] = 'Your address has been saved'
      redirect_to questionnaire_path
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:street1, :street2, :city, :state,
                                    :postal_code, :country_code)
  end

  def verify_user
    @user = current_user
    @user.verify

    @user.save
  end
end
