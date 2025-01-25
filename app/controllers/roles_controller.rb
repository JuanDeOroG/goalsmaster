require_dependency "Roles/ListRolesUseCase"
require_dependency "Roles/UpdateRolePermissionsUseCase"
require_dependency "Permissions/ListPermissionsUseCase"

class RolesController < ApplicationController
  before_action :authenticate_user!

  def initialize
    @listRolesUseCase = ListRolesUseCase.new
    @listPermissionsUseCase = ListPermissionsUseCase.new
    @updateRolePermissionsUseCase = UpdateRolePermissionsUseCase.new

    super()
  end

  def index
    @roles = @listRolesUseCase.call(params, pagination = true)
    @role = Role.new # To use in the modal creation

    @permissionList = @listPermissionsUseCase.call(params, pagination = false)
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

  def updateRolePermissions
    if @updateRolePermissionsUseCase.call(role_permissions_params)
      redirect_to roles_path, notice: "Permissions was assigned to the Role successfully"
    else
      redirect_to roles_path, alert: "Permissions was not assigned to the Role"
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

  def role_permissions_params
    params.permit(:id, permissions: [])
  end
end
