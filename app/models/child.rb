class Child < ApplicationRecord
  belongs_to :user
  has_many :child_posts, dependent: :destroy
  has_many :posts, through: :child_posts

  enum age: {
    before_birth: 0,
    age_0: 1,
    age_1: 2,
    age_2_3: 3,
    age_4_5: 4,
    age_6_7: 5,
    age_8_10: 6,
    age_11_12: 7,
    age_13_15: 8
  }

  enum gender: {
    unknown: 0,
    boy: 1,
    girl: 2
  }
end
