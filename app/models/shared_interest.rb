class SharedInterest # not an ActiveRecord!
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :game_id, :users, :game, :teachers

  def initialize(game_id)
    @game_id = game_id
  end

  def query
    @game = Game.find(game_id)
    @users = User.joins(interest: :game).where('games.id' => game_id, 'interests.can_teach' => false).all
    @teachers = User.joins(interest: :game).where('games.id' => game_id, 'interests.can_teach' => true).all
    self
  end
end
