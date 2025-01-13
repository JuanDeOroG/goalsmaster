class ListRolesUseCase
    def call(params, pagination = true)
        roles = apply_filters_in_list(params, pagination)

        roles
    end

    def apply_filters_in_list(params, pagination)
        roles = Role.all
        roles = roles.filter_by_name(params[:name])
        roles = roles.filter_by_state(params[:state])

        pagination ? roles.page(params[:page]).per(10) : roles
    end
end
