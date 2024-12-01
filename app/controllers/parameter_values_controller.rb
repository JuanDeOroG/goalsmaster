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
      flash[:alert] = "Valor parametro #{@parameter_value.name} creado correctamente."

      redirect_to @parameter_value
    else
      flash[:alert] = @parameter_value.errors.full_messages.to_sentence
      redirect_to new_parameter_value_path(parameter_value: parameter_values_params)

    end
  end

  def edit
    @parameter_value = ParameterValue.find(params[:id])
    @parameters = @list_parameters_use_case.call(params, false)
  end
  def update
    @parameter_value = ParameterValue.find(params[:id])
    if @parameter_value.update(parameter_values_params)
      flash[:alert] = "Valor parametro #{@parameter_value.name} actualizado correctamente."

    else
      flash[:alert] = @parameter_value.errors.full_messages.to_sentence

    end
    redirect_to(edit_parameter_value_path)
  end

  def parameter_values_params
    params.require(:parameter_value).permit(:id, :name, :state, :parameter_id)
  end
end
