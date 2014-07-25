class PagesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def unverified
    @user = current_user
    @address = Address.new
  end

  def questionnaire
  end
end
