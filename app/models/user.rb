class User < ApplicationRecord
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  belongs_to :area, optional: true
  has_one_attached :profile_image
  has_many :children, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      # デフォルト画像（app/assets/images/no_image.jpg）を使う場合
      'no_image.jpg'
    end
  end
  
end


