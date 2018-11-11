class Game < ApplicationRecord
  belongs_to :event
  belongs_to :suggestor, class_name: 'User'
  has_many :interests
  has_many :users, through: :interests

  def duration_minutes
    duration_secs.nil? ? nil : duration_secs / 60
  end

  def duration_minutes=(n)
    self.duration_secs = n * 60
  end

  def player_range
    case [min_players.present?, max_players.present?]
    when [false, false]
      ""
    when [true, false]
      "#{min_players}"
    when [false, true]
      "#{max_players}"
    when [true, true]
      if min_players == max_players
        "#{max_players}"
      else
        "#{min_players}-#{max_players}"
      end
    end
  end

  def bgg_link
    if bgg_id.present?
      return "https://boardgamegeek.com/boardgame/" + bgg_id
    end
    read_attribute(:bgg_link)
  end

  def user_interest(user)
    interests.find{|i| i.user_id == user.id}
  end

  def interest_sort_key(user)
    if user_interest(user).present?
      "interested"
    else
      "not interested"
    end
  end
end
