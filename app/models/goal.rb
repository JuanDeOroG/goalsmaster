class Goal < ApplicationRecord
  validates :title, :user_id, :created_by, :updated_by, :state, presence: true
  validates :title, length: { maximum: 50 }
  validates :code, uniqueness: true

  # SINTAX: belong_to :relation_name, class_name: "model", foreign_key: "column_name"
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :creator, class_name: "User", foreign_key: "created_by"
  belongs_to :updater, class_name: "User", foreign_key: "updated_by"

  scope :filter_by_title, ->(title) { where("title LIKE ? OR description LIKE ?", "%#{title}%", "%#{title}%") if title.present? }
  scope :filter_by_state, ->(state) { where(state: state) if state.present? }
  scope :filter_by_creator, ->(current_user) { where(created_by: current_user.id) }

  def setCreator(goal, current_user)
    goal.user_id = current_user.id
    goal.created_by = current_user.id
    goal.updated_by = current_user.id
    goal
  end

  def getGoalProgress
  end
end
