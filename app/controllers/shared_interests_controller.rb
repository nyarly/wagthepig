class SharedInterestsController < ApplicationController
  before_action :authenticate_user!

  def show
    @shared_interest = SharedInterest.new(shared_interest_params).query
  end

  private

  def shared_interest_params
    params.require(:game_id)
  end
end
