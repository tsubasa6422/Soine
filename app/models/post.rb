class Post < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :child_posts, dependent: :destroy
  has_many :children, through: :child_posts

  validates :title, presence: true
  validates :body, presence: true
end
