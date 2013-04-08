class User < ActiveRecord::Base
  has_many :karma_points

  #query used to update: User.all.each{ |u| u.update_attribute(:karma_sum, u.karma_points.pluck(:value).sum) }
  attr_accessible :first_name, :last_name, :email, :username, :karma_sum

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}

  def self.by_karma
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
    User.order('karma_sum DESC')
  end

  def total_karma
    self.karma_sum
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
