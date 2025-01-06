class ListParametersUseCase
  def call(params, pagination = true)
    # Aquí se obtienen los parámetros con los filtros aplicados

    # Aplica los filtros si existen
    parameters = apply_filters_in_list(params, pagination)

    parameters
  end

  def apply_filters_in_list(params, pagination)
    parameters = Parameter.all
    parameters = parameters.filter_by_name(params[:name])
    parameters = parameters.filter_by_state(params[:state])

    pagination ? parameters.page(params[:page]).per(10) : parameters
  end
end
