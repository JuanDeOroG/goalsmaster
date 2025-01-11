class Permission < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: 50
    validates :state, presence: true, length: {maximum: 1} 

    has_and_belongs_to_many :roles, join_table: "roles_permissions", foreign_key: "role_id", association_foreign_key: "permission_id"
end