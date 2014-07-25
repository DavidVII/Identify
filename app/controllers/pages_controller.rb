class PagesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def unverified
    @user = current_user
    @address = @user.build_address
  end

  def questionnaire
  end
end
