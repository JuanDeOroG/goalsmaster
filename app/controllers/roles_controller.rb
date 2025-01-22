require_dependency "Roles/ListRolesUseCase"

class RolesController < ApplicationController
  before_action :authenticate_user!

  def initialize
    @listRolesUseCase = ListRolesUseCase.new
    super()
  end

  def index
    @roles = @listRolesUseCase.call(params, true)
    @role = Role.new # Para el formulario de creación
  end

  def create
    role = Role.new(role_params)
    if role.save
      redirect_to roles_path, notice: "Role was created successfully"
    else
      error_messages = role.errors.full_messages.join(", ")
      redirect_to roles_path, alert: "Role was not Created: #{error_messages}"
    end
  end

  def edit
    @role = Role.find(params[:id])
    render partial: "roles/partials/form", locals: { role: @role }
  end

  def update
    role = Role.find(params[:id])
    if role.update(role_params)
      redirect_to roles_path, notice: "Role was updated successfully"
    else
      error_messages = role.errors.full_messages.join(", ")
      redirect_to roles_path, alert: "Role was not updated: #{error_messages}"
    end
  end

  def destroy
    role = Role.find(params[:id])
    if role.update(state: 2)
      redirect_to roles_path, notice: "Role was deleted successfully"
    else
      error_messages = role.errors.full_messages.join(", ")
      redirect_to roles_path, alert: "Role was not Deleted: #{error_messages}"
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
