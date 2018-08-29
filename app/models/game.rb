class Game < ApplicationRecord
  belongs_to :event
  belongs_to :suggestor, class_name: 'User'
  has_many :interests
  has_many :users, through: :interests
end
