class Member < ApplicationRecord
  validates :first_name, :last_name, :url, presence: true

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :headings

  def full_name
    "#{first_name} #{last_name}"
  end

  def shorten_url
    self.short_url = ShortUrl.new(url).shorten
  end

  def create_headings(headings)
    headings_records = headings.map { |heading| self.headings.new(name: heading.downcase) }

    Heading.import(headings_records)
  end
end
