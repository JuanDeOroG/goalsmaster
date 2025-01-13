require_dependency "Roles/ListRolesUseCase"
class RolesController < ApplicationController
    def initialize
      @listRolesUseCase = ListRolesUseCase.new
      super()
    end
    def index
        @roles = @listRolesUseCase.call(params)
    end

    def create
      role = Role.new(name: params[:name])
      if role.save
        redirect_to roles_path, notice: "Role was create successfully"
      else
        redirect_to roles_path, alert: "Role was not create"

      end
    end
end
