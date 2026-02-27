# app/models/report.rb
class Report < ApplicationRecord
  belongs_to :post
  belongs_to :reporter, class_name: "User"

  enum reason: {
    spam: 0,          # スパム/宣伝
    harassment: 1,    # 誹謗中傷
    privacy: 2,       # 個人情報
    inappropriate: 3, # 不適切な内容
    other: 4
  }

  enum status: {
    open: 0,        # 未対応
    investigating: 1, # 対応中
    resolved: 2     # 対応済
  }

  validates :reason, presence: true
  validates :post_id, uniqueness: { scope: :reporter_id, message: "はすでに通報済みです" }

  validate :detail_length_if_other

  private

  def detail_length_if_other
    if other? && detail.to_s.strip.length < 5
      errors.add(:detail, "は5文字以上で入力してください（理由がその他の場合）")
    end
  end
end