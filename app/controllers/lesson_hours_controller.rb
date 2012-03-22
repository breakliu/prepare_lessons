class LessonHoursController < ApplicationController
  load_and_authorize_resource
  include_kindeditor :only => [:new, :edit, :update, :create]
  # GET /lesson_hours
  # GET /lesson_hours.json
  def index
    @lesson_hours = LessonHour.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lesson_hours }
    end
  end

  # GET /lesson_hours/1
  # GET /lesson_hours/1.json
  def show
    @lesson_hour = LessonHour.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson_hour }
    end
  end

  # GET /lesson_hours/new
  # GET /lesson_hours/new.json
  def new
    @lesson_hour = LessonHour.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson_hour }
    end
  end

  # GET /lesson_hours/1/edit
  def edit
    @lesson_hour = LessonHour.find(params[:id])
  end

  # POST /lesson_hours
  # POST /lesson_hours.json
  def create
    @lesson_hour = LessonHour.new(params[:lesson_hour])

    respond_to do |format|
      if @lesson_hour.save
        format.html { redirect_to @lesson_hour, notice: 'Lesson hour was successfully created.' }
        format.json { render json: @lesson_hour, status: :created, location: @lesson_hour }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lesson_hours/1
  # PUT /lesson_hours/1.json
  def update
    @lesson_hour = LessonHour.find(params[:id])

    respond_to do |format|
      if @lesson_hour.update_attributes(params[:lesson_hour])
        format.html { redirect_to @lesson_hour, notice: 'Lesson hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_hours/1
  # DELETE /lesson_hours/1.json
  def destroy
    @lesson_hour = LessonHour.find(params[:id])
    @lesson_hour.destroy

    respond_to do |format|
      format.html { redirect_to lesson_hours_url }
      format.json { head :no_content }
    end
  end
end
