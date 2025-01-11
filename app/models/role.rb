class Role < ApplicationRecord
    # Name role must be unique and obligatory, its max length is 50 digits 
    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
    # Role state must must be and be one digit of length
    validates :state, presence: true, length: {maximum: 1} 

    has_and_belongs_to_many :permissions, join_table: "roles_permissions", foreign_key: "role_id", association_foreign_key: "permission_id"
end
