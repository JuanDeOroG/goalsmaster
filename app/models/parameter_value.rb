class ParameterValue < ApplicationRecord
  validates :id, :name, uniqueness: { message: "El identificador ya está en uso. Por favor, digita otro." }
  validates :id, :name, :state, presence: true
  scope :filter_by_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
  scope :filter_by_state, ->(state) { where(state: state) if state.present? }
  scope :filter_by_parameter, ->(parameter_id) { where(parameter_id: parameter_id) if parameter_id.present? }
end
