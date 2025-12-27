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

  enum gender: {
    unknown: 0,
    boy: 1,
    girl: 2
  }

  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true

  validates :age_months,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 36 },
            allow_nil: true

  validate :age_months_rules

  def gender_label
    case gender
    when "boy" then "男の子"
    when "girl" then "女の子"
    else "性別未設定"
    end
  end


  def age_label
    return "出生前" if before_birth?
    return "#{age_months}ヶ月" if age_months.present?

    {
      "age_0"        => "0歳",
      "age_1"        => "1歳",
      "age_2_3"      => "2〜3歳",
      "age_4_5"      => "4〜5歳",
      "age_6_7"      => "6〜7歳",
      "age_8_10"     => "8〜10歳",
      "age_11_12"    => "11〜12歳",
      "age_13_15"    => "13〜15歳"
    }[age]
  end

  def public_label
    "#{age_label}・#{gender_label}"
  end

  private

  def age_months_rules
    if before_birth? && age_months.present?
      errors.add(:age_months, "は出生前の場合は入力できません")
    end

    if !before_birth? && age_months.present? && !age_0?
      errors.add(:age_months, "は0歳のときのみ入力できます")
    end
  end
end
