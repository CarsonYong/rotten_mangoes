class Movie < ActiveRecord::Base

  has_many :reviews
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  # validates :poster_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_future



  def review_average
    if reviews.size == 0
       0
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  def self.by_duration(duration)
    if duration == "Under 90 minutes"
        self.where("runtime_in_minutes < 90 ", "%#{duration}%")
      elsif duration == "Between 90 and 120 minutes"
        where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120 ", "%#{duration}%")
      else
        self.where("runtime_in_minutes > 120 ", "%#{duration}%")
      end       
  end

  def self.by_title(title)
    self.where("title like ?", "%#{title}%")
  end

  def self.by_director(director)
    self.where("director like? ", "%#{director}%")
  end
    


  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
