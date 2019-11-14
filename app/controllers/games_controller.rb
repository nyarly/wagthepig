class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    @game.event_id = params[:event_id]
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    find_params = game_params.extract!(:bgg_id, :event_id)

    @game = Game.create_with(game_params).find_or_create_by(find_params)

    if @game.users.count == 0
      @game.suggestor = current_user
      @game.users << current_user
    end

    if @game.save
      if @game.bgg_id.present?
        redirect_to @game.event, notice: 'Game was successfully created.'
      else
        redirect_to @game, notice: 'Game was successfully created.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game.event, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params
        .require(:game)
        .permit(:name, :min_players, :max_players, :bgg_id, :duration_minutes, :event_id, :pitch)
        .tap do |params|
        params[:duration_secs] = params.delete(:duration_minutes).to_i * 60
      end
    end
end
