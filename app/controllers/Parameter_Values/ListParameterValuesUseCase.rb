class ListParameterValuesUseCase
  def call(params, pagination = true)
    # Aquí se obtienen los parámetros con los filtros aplicados

    # Aplica los filtros si existen
    parameter_values = apply_filters_in_list(params, pagination)

    parameter_values
  end

  def apply_filters_in_list(params, pagination)
    parameter_values = ParameterValue.all
    parameter_values = parameter_values.filter_by_name(params[:name])
    parameter_values = parameter_values.filter_by_state(params[:state])
    parameter_values = parameter_values.filter_by_parameter(params[:parameter_id])

    pagination ? parameter_values.page(params[:page]).per(10) : parameter_values
  end
end
