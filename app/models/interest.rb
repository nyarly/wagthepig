class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def sort_key
    if can_teach
      "30 - can teach"
    else
      "20 - interested"
    end
  end

  def classname
    if can_teach
      "canteach"
    else
      "interested"
    end
  end
end

class NullInterest
  def self.itself
    return @instance ||= new
  end

  def sort_key
    "10 - not interested"
  end

  def classname
    "not_interested"
  end

  def present?
    false
  end

  def blank?
    true
  end

  def nil?
    true
  end

  private :initialize
end
