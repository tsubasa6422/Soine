class Post < ApplicationRecord
  belongs_to :user
  belongs_to :area, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
    def liked_by?(user)
      likes.exists?(user_id: user.id)
    end
    
  has_many :child_posts, dependent: :destroy
  has_many :children, through: :child_posts
   has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
end
