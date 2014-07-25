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
      direct_user
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @address = @user.address
  end

  def update
    @user = current_user
    @address = Address.find(params[:id])
    @address.update_attributes(address_params)

    if @address.save
      verify_user
      direct_user
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
    current_user.verify
    current_user.save
  end

  def direct_user
    if current_user.verified?
      flash[:success] = 'Your address has been saved'
      redirect_to questionnaire_path
    else
      flash[:alert] = "You were not verified with those details"
      redirect_to edit_address_path(@address)
    end
  end
end
