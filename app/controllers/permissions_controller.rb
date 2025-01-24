require_dependency "Permissions/ListPermissionsUseCase"

class PermissionsController < ApplicationController
  before_action :authenticate_user!

  def initialize
    @listPermissionsUseCase = ListPermissionsUseCase.new
    super()
  end

  def index
    @permissions = @listPermissionsUseCase.call(params, pagination = true)
    @permission = Permission.new
  end

  def create
    permission = Permission.new(permission_params)
    if permission.save
      redirect_to permissions_path, notice: "Permission was created successfully"
    else
      error_messages = permission.errors.full_messages.join(", ")
      redirect_to permission_path, alert: "Permission was not Created: #{error_messages}"
    end
  end

  def edit
    @permission = Permission.find(params[:id])
    render partial: "permissions/partials/form", locals: { permission: @permission }
  end

  def update
    permission = Permission.find(params[:id])

    if permission.update(permission_params)
      redirect_to permissions_path, notice: "Permission updated successfully"
    else
      error_messages = permission.errors.full_messages.join(", ")
      redirect_to permissions_path, alert: "Permission was not Updated: #{error_messages}"
    end
  end

  def destroy
    permission = Permission.find(params[:id])
    # Change state to deleted (2)
    if permission.update(state: 2)
      redirect_to permissions_path, notice: "Permission deleted successfully"
    else
      error_messages = permission.errors.full_messages.join(", ")
      redirect_to permissions_path, alert: "Permission was not deleted: #{error_messages}"
    end
  end

  private

  def permission_params
    params.require(:permission).permit(:name)
  end
end
