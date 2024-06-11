class PostEvent < ApplicationRecord
  
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  
  validates :title, presence: true
  validates :event_date, presence: true
  validates :address, presence: true
  
  geocoded_by :address
  after_validation :geocode
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
    # image.variant(resize_to_fill: [width, height]).processed
  end
end