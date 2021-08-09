class Member < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true

  has_many :friendships
  has_many :friends, through: :friendships

  def shorten_url
    self.short_url = ShortUrl.new(url).shorten
  end
end
