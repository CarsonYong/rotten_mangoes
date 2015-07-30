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

  # scope :by_duration, lambda { where("runtime_in_minutes < 90 ", "%#{duration}%") if duration == "Under 90 minutes"}
   # scope :by_duration, -> duration {
   #  where("runtime_in_minutes > duration or runtime_in_minutes <= 120 ", "%#{duration}%") if duration == "Under 90 minutes"}
   scope :by_duration, lambda {|start, finish| where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", start, finish)}
  #scope :by_duration, lambda { |duration| if duration == "Under 90 minutes" then where("runtime_in_minutes < 90 ", "%#{duration}%") elsif duration == "Between 90 and 120 minutes" then where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120 ", "%#{duration}%") else where("runtime_in_minutes > 120 ", "%#{duration}%")end }


  # def self.by_duration(duration)
  #   if duration == "Under 90 minutes"
  #       self.where("runtime_in_minutes < 90 ", "%#{duration}%")
  #     elsif duration == "Between 90 and 120 minutes"
  #       where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120 ", "%#{duration}%")
  #     else
  #       self.where("runtime_in_minutes > 120 ", "%#{duration}%")
  #     end       
  # end
scope :by_search, lambda {|search| 
    where("title LIKE ? or director LIKE ?", "%#{search}%" , "%#{search}%")
}

  # scope :by_title, ->(search) { where("title like ?", "%#{title}%") }

  # # def self.by_title(title)
  # #   self.where("title like ?", "%#{title}%")
  # # end


  # scope :by_director, ->(search) { where("director like? ", "%#{director}%") }
  # def self.by_director(director)
  #   self.where("director like? ", "%#{director}%")
  # end
    


  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
