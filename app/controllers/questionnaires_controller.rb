class QuestionnairesController < ApplicationController
  def show
    @user = current_user
    @questions_hash = current_user.retrieve_questions
  end
end

