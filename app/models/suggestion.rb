class Suggestion # not an ActiveRecord!
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :event_id, :user_ids, :extra_players, :users, :games

  def initialize(user_id, params)
    @event_id, @user_ids, @extra_players = params.values_at(:event_id, :user_ids, :extra_players)
    @current_user_id = user_id
    @extra_players = 0 unless @extra_players.present?
  end

  def params
    { event_id: @event_id, extra_players: @extra_players, user_ids: @user_ids }
  end

  def new_query
    @users = User.joins(interest: {game: :event}).where('events.id' => @event_id).distinct

    self
  end

  def show_query
    user_ids = (@user_ids.select{|id| id != ""} + [@current_user_id]).uniq
    must_play = user_ids.length + extra_players.to_i
    @games = Game.joins(:event, :users)
      .select(<<-QUERY)
      games.*,
      count('games.id') as interest_level,
      count('games.id') FILTER (WHERE interests.can_teach is true) as teachers
      QUERY
      .where('coalesce(games.max_players, 9999) >= ?', must_play)
      .where('events.id' => @event_id)
      .where('users.id' => user_ids)
      .order('interest_level desc, teachers desc')
      .group('games.id')
    @users = User.where(id: user_ids)
    self
  end

  def persisted?
    false
  end
end
