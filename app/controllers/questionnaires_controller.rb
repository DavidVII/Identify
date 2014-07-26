class QuestionnairesController < ApplicationController
  before_action :check_user

  def show
    @user = current_user
    @questions_hash = current_user.retrieve_questions
  end

  def score_question_set
    knowledge_based_authentication(request.params)
    if current_user.score > 75
      flash[:success] = "You have been authenticated!"
      redirect_to success_page_path
    else
      flash[:alert] = "Please try again"
      redirect_to questionnaire_path
    end
  end

  private

  def check_user
    unless current_user.verified?
      flash[:alert] = "Whoa cowboy! You'll need to be verified first."
      redirect_to edit_address_path(current_user.address)
    end
  end

  def knowledge_based_authentication(submitted_answers)
    sorted_answers = submitted_answers.select { |k| k.to_s.include?('answer')}
    current_user.kb_authenticate(sorted_answers)
    current_user.save
  end
end

