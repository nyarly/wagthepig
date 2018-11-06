class SuggestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @suggestion = Suggestion.new(current_user.id, suggestion_params).new_query
  end

  def show
    @suggestion = Suggestion.new(current_user.id, suggestion_params).show_query
  end

  private
  # Only allow a trusted parameter "white list" through.
  def suggestion_params
    params.require(:suggestion).permit(:event_id, :extra_players, user_ids: [])
  end
end
