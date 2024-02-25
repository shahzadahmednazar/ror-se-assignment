# app/controllers/employees_controller.rb

class EmployeesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @employees = EmployeeFacade.fetch_all(params[:page])
  end
  
  def edit
    @employee = EmployeeFacade.fetch(params[:id])
  end

  def show
    @employee = EmployeeFacade.fetch(params[:id])
  end

  def create
    @employee = EmployeeFacade.create(employee_params)
    redirect_to employee_path(@employee["id"])
  end
  
  def update
    @employee = EmployeeFacade.update(params[:id], employee_params)
    redirect_to employee_path(@employee["id"])
  end  

  private

  def employee_params
    params.permit(:name, :position, :date_of_birth, :salary)
  end
end
