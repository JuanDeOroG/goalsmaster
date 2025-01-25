class UpdateRolePermissionsUseCase
  def call(params)
    puts params.inspect

    permissions = params[:permissions]
    role_id = params[:id]
    role = Role.find(role_id)
    return false unless role

    role.permissions = Permission.where(id: permissions) # Asigna o elimina los permisos al rol
    role.save
  end
end
