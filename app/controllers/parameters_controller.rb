class ParametersController < ApplicationController
  def index
  end

  def new
    @parameter = Parameter.new
    @enviar = "Create"
  end

  def create
    @parameter = Parameter.new(parameter_params)
    @parameter.state = 1

    if @parameter.save
      redirect_to @parameter, notice: "Parametro Creado Correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def parameter_params
    params.require(:parameter).permit(:id, :name, :state)
  end

  def show
    @parameter = Parameter.find(params[:id])
  end

  def edit
    @parameter = Parameter.find(params[:id])
  end

  def update
    @parameter = Parameter.find(params[:id])  # Encuentra el parámetro por ID

  if @parameter.update(parameter_params)  # Actualiza el parámetro con los parámetros permitidos
    redirect_to @parameter, notice: "Parámetro actualizado exitosamente."
  else
    render :edit  # Si hay errores, vuelve a renderizar el formulario de edición
  end
  end
end
