class User < ActiveRecord::Base
  has_many :favorite_recipes  
  has_many :favorites, through: :favorite_recipes, source: :recipe
  has_many :recipes
  belongs_to :role
  before_create :set_default_role

  enum role: [:Member, :Admin, :Manager]

  private
  def set_default_role
    self.role ||= Role.find_by_name('Member')
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
end
