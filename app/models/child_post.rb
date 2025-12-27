class ChildPost < ApplicationRecord
  belongs_to :post
  belongs_to :child

  before_validation :snapshot_child, on: :create

  private

  def snapshot_child
    self.child_name       ||= child.name
    self.child_age        ||= child.age
    self.child_age_months ||= child.age_months
    self.child_gender     ||= child.gender
  end
end
