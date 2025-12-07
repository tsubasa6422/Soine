class Child < ApplicationRecord

  
  belongs_to :user
  has_one_attached :image
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

  def age_label
    {
      "before_birth" => "出生前",
      "age_0"        => "0歳",
      "age_1"        => "1歳",
      "age_2_3"      => "2〜3歳",
      "age_4_5"      => "4〜5歳",
      "age_6_7"      => "6〜7歳",
      "age_8_10"     => "8〜10歳",
      "age_11_12"    => "11〜12歳",
      "age_13_15"    => "13〜15歳"
    }[self.age]
  end


  enum gender: {
    unknown: 0,
    boy: 1,
    girl: 2
  }

  has_one_attached :image
end
