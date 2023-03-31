# frozen_string_literal: true

class DepartmentsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_department, except: %i[index new create]

  def index
    @department = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        flash[:notice] = 'Department was successfully created.'
        format.html { redirect_to department_path(@department) }
      else
        flashp[:alert] = 'Error creating department.'
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @department.update(department_params)
        flash[:notice] = 'Department has been updated.'
        format.html { redirect_to department_path(@department) }
      else
        flash[:alert] = 'Error updating department.'
        render :edit
      end
    end
  end

  def destroy
    respond_to do |format|
      if @department.delete
        flash[:notice] = 'Department has been deleted.'
        format.html { redirect_to departments_path }
      end
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :motto, :mission)
  end

  def set_department
    @department = Department.find(params[:id])
  end
end
