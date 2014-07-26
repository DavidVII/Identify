class PagesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if current_user.present? && current_user.score > 75
      redirect_to success_page_path
    elsif current_user.present?
      direct_user
    end
  end

  def success
    if current_user.score < 75
      flash[:alert] = 'You have not been authorized yet'
      direct_user
    end
  end

  private

  def direct_user
    if current_user.confirmed? && current_user.verified?
      redirect_to questionnaire_path
    elsif current_user.confirmed? && current_user.verified? == false
      redirect_to new_address_path
    end
  end
end
