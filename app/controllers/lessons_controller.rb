# coding: utf-8
class LessonsController < ApplicationController
  before_filter :require_login, :except => [:index, :index2, :show_lesson, :show, :course]
  include_kindeditor :only => [:new, :edit, :update, :create]
  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  # root_url
  def index2
    @chinese = Lesson.chinese_all
    @math = Lesson.math_all
    @english = Lesson.english_all
    @zhonghe = Lesson.zhonghe_all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  def course
    @lessons = Lesson.where(:course => Lesson::COURSES[params[:course_id].to_i]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  def myhome
    @lessons = Lesson.where(:user_id => params[:user_id]).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end
  
  def show_lesson 
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    @lesson = Lesson.new
    @lesson_hour = LessonHour.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/1/edit
  def edit
    @lesson = Lesson.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(params[:lesson])
    
    if logged_in? 
      @lesson[:user_id] = current_user.id
    end

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to myhome_path(current_user), notice: '创建成功' } if logged_in?
        format.html { redirect_to @lesson, notice: '创建成功' } if not logged_in?
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to myhome_path(current_user), notice: '更新成功' } if logged_in?
        format.html { redirect_to @lesson, notice: '更新成功' } if not logged_in?
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to myhome_path(current_user), notice: '删除成功' } if logged_in?
      format.html { redirect_to lessons_url, notice: '删除成功' } if not logged_in?
    end
  end
end
