class AppointmentTypesController < ApplicationController
  def index
    @appointment_types = AppointmentType.all
    authorize @appointment_types
  end

  def edit
    @appointment_type = AppointmentType.find(params[:id])
    authorize @appointment_type
  end

  def update
    @appointment_type = AppointmentType.find(params[:id])
    authorize @appointment_type

    if @appointment_type.update(place_params)
      redirect_to appointment_types_path
    else
      render :edit
    end
  end

  private

  def place_params
    params.require(:appointment_type).permit(:name, notification_types_attributes: [:id, :template, :reminder_period])
  end
end