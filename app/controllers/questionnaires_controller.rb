class QuestionnairesController < ApplicationController
  before_action :check_user

  def show
    @user = current_user
    @questions_hash = current_user.retrieve_questions
  end

  private

  def check_user
    unless current_user.verified?
      flash[:alert] = "Whoa cowboy! You'll need to be verified first."
      redirect_to edit_address_path(current_user.address)
    end
  end
end

