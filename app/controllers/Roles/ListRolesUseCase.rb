class ListRolesUseCase
    def call(params, pagination = true)
        roles = apply_filters_in_list(params, pagination)

        roles
    end

    def apply_filters_in_list(params, pagination)
        roles = Role.includes(:permissions)
        roles = roles.filter_by_name(params[:name])
        roles = roles.filter_by_state(params[:state])
        roles.each do |role|
            puts "Role: #{role.name}, Permissions: #{role.permissions.map(&:name)}"
          end
        pagination ? roles.page(params[:page]).per(10) : roles
    end
end
