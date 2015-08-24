class Recipe < ActiveRecord::Base
  acts_as_taggable
  has_many :favorite_recipes
  has_many :favorited_by, through: :favorite_recipes, source: :user
  belongs_to :user
  belongs_to :category
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 } 
  validates :ingredients, presence: true, length: { maximum: 2000 } 
  validates :method, presence: true, length: { maximum: 10000 } 
  validate :picture_size
  validates :category_id, presence: true




  
  def favorited_by?(other_user)
    favorited_by.include?(other_user)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less then 5MB")
    end
  end
end
