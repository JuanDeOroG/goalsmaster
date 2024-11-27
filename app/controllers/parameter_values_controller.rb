require_dependency "Parameters/ListParametersUseCase"

class ParameterValuesController < ApplicationController
  def initialize
    @list_parameters_use_case = ListParametersUseCase.new
    super()  # Llamamos al inicializador de ApplicationController
  end
  def index
    @parameter_values = ParameterValue.page(params[:page]).per(10)
  end

  def new
    @parameter_value = ParameterValue.new
    @parameters = @list_parameters_use_case.call(params, false)
  end

  def create
    @parameter_value = parameter_values_params
    @parameter_value.state = 1

    if @parameter_value.save
      redirect_to @parameter_value, notice: "Valor Parametro Creado Correctamente."
    else
      render :new, status: :unprocessable_entity

    end
  end

  def parameter_values_params
    params.require(:parameter_value).permit(:id, :name, :state, :parameter_id)
  end
end
