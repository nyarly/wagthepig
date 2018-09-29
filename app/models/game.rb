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
end
