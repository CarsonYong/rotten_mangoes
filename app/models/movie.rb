class Movie < ActiveRecord::Base

  has_many :reviews
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future



  def review_average
    if reviews.size == 0
       0
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  scope :by_duration, lambda {|start, finish| where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", start, finish)}

  scope :by_search, lambda {|search| where("title LIKE ? or director LIKE ?", "%#{search}%" , "%#{search}%")}

  protected

  def release_date_is_in_the_future
    errors.add(:release_date, "should probably be in the future") if release_date.present? && release_date < Date.today
  end
end
