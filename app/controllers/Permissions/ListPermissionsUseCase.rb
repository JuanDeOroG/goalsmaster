class ListPermissionsUseCase
  def call(params, pagination)
    permission = apply_filters_in_list(params, pagination)
    permission
  end

  def apply_filters_in_list(params, pagination)
    permissions = Permission.all
    permissions = permissions.filter_by_name(params[:name])
    permissions = permissions.filter_by_state(params[:state])

    pagination ? permissions.page(params[:page]).per(10) : permissions
  end
end
