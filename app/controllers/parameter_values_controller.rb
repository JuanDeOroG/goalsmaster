require_dependency "Parameters/ListParametersUseCase"
require_dependency "Parameter_Values/ListParameterValuesUseCase"

class ParameterValuesController < ApplicationController
  def initialize
    @list_parameters_use_case = ListParametersUseCase.new
    @list_parameter_values_use_case = ListParameterValuesUseCase.new

    super()  # Llamamos al inicializador de ApplicationController
  end
  def index
    @parameter_values = @list_parameter_values_use_case.call(params, true)
  end

  def new
    @parameter_value = ParameterValue.new # Para asignar el modelo al formulario
    @parameters = @list_parameters_use_case.call(params, false)
  end

  def create
    @parameter_value = ParameterValue.new(parameter_values_params) # Instanciar un objeto y filtrar la informacion del request
    @parameter_value.state = 1

    if @parameter_value.save
      redirect_to parameter_values_path, notice: "Valor parámetro #{@parameter_value.name} creado correctamente."
    else
      redirect_to new_parameter_value_path(parameter_value: parameter_values_params), alert: @parameter_value.errors.full_messages.to_sentence
    end
  end

  def edit
    @parameter_value = ParameterValue.find(params[:id]) # se manda el id del parametro mediante la url/request/params
    @parameters = @list_parameters_use_case.call(params, false) # Listado de parametros para select de parametros
  end
  def update
    @parameter_value = ParameterValue.find(params[:id])
    # Rails.logger.debug "Parámetros permitidos: #{parameter_values_params.inspect}"
    # Rails.logger.debug "Parámetros permitidos sin inspect: #{parameter_values_params}"
    # byebug

    if @parameter_value.update(parameter_values_params)
      redirect_to edit_parameter_value_path, alert: "Valor parametro #{@parameter_value.name} actualizado correctamente."
    else
      redirect_to edit_parameter_value_path, alert: @parameter_value.errors.full_messages.to_sentence
    end
  end

  def parameter_values_params
    params.require(:parameter_value).permit(:id, :name, :state, :parameter_id)
  end
end
