class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true

  after_create :add_to_user_karma_sum
  before_destroy :subtract_from_user_karma_sum

private

  def add_to_user_karma_sum
    user.karma_sum ||= 0
    user.update_attributes(:karma_sum => user.karma_sum + value)
  end

  def subtract_from_user_karma_sum
    user.update_attributes(:karma_sum => user.karma_sum - value)
    return true
  end
end
