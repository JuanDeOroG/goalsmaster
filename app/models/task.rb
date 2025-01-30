class Task < ApplicationRecord
  belongs_to :goal
  belongs_to :user

  scope :filter_by_name, ->(name)  { where("name LIKE ?", "%#{name}%") if name.present? }
  scope :filter_by_goalId, ->(goalId) { where(goal_id: goalId) if goalId.present? }
  scope :filter_by_state, ->(state) { where(:state, state) if state.present? }
end
