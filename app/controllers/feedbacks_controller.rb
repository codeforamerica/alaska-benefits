class FeedbacksController < ApplicationController

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)

    respond_to do |f|
      f.html { redirect_to tasks_url }
      f.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a trusted parameter "white list" through.
    def feedback_params
      params.require(:feedback).permit(:rating, :comments)
    end
end
