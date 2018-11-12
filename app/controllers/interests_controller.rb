class InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interest, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @interest = Interest.new(interest_params)

    if @interest.save
      redirect_to (event_path(@interest.game.event_id) + "#game-#{@interest.game.id}")
    else
      render :new
    end
  end

  def update
    if @interest.update(interest_params)
      redirect_to (event_path(@interest.game.event_id) + "#game-#{@interest.game.id}")
    else
      render :edit
    end
  end

  def destroy
    @interest.destroy
    redirect_to (event_path(@interest.game.event_id) + "#game-#{@interest.game.id}")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  private

  def set_interest
    @interest = Interest.includes(game: :event).find(params[:id])
  end

  def interest_params
    params.require(:interest).permit(:notes, :game_id, :user_id, :can_teach)
  end
end
