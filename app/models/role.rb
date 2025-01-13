class Role < ApplicationRecord
    # Name role must be unique and obligatory, its max length is 50 digits
    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
    # Role state must must be and be one digit of length
    validates :state, presence: true, length: { maximum: 1 }

    has_and_belongs_to_many :permissions, join_table: "roles_permissions", foreign_key: "role_id", association_foreign_key: "permission_id"

    scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
    scope :filter_by_state, ->(state) { where(:state, state) if state.present? }
end
