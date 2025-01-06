class Parameter < ApplicationRecord
  scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
  scope :filter_by_state, ->(state) { where(state: state) if state.present? }
end
