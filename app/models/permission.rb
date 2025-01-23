class Permission < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
    validates :state, presence: true, length: { maximum: 1 }

    has_and_belongs_to_many :roles, join_table: "roles_permissions", foreign_key: "role_id", association_foreign_key: "permission_id"

    scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
    scope :filter_by_state, ->(state) { where(:state, state) if state.present? }
end
