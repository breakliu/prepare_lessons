# coding: utf-8
class LessonsController < ApplicationController
  load_and_authorize_resource
  before_filter :require_login, :except => [:index, :index2, :show_lesson, :show, :course, :search_lesson, :select_search, :advanced_search]
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
    @plans = Plan.limit(6).all
    @summarizes = Summarize.limit(6).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  def advanced_search
    @users = User.all
    @terms = Term.all
    str = {}
    str[:course] = params[:course] if not params[:course].blank?
    str[:grade] = params[:grade] if not params[:grade].blank?
    str[:user_id] = params[:user_id] if not params[:user_id].blank?
    if not params[:term_id].blank?
      str[:term_id] = params[:term_id]
    else
      str[:term_id] = Term.first
    end
    @lessons = Lesson.where(str);
    
    #@course = Lesson::COURSES[params[:course_id].to_i]
    #@lessons = Lesson.where(:course => @course, 
    #                        :term_id => params[:term_id], 
    #                        :grade => params[:grade], 
    #                        :user_id => params[:user_id])#.paginate(:page => params[:page])
    @hours = 0
    @lessons.each do |lesson|
      @hours += lesson.class_hour.to_i
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  def course
    @course = Lesson::COURSES[params[:course_id].to_i]
    @lessons = Lesson.where(:course => @course).paginate(:page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  def myhome
    @lessons = Lesson.where(:user_id => current_user.id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end
  
  def search_lesson
    @lessons = []
    @search_str = ''
    if not params[:search_str].blank?
      search_str = '%' + params[:search_str] + '%'
    
      # 搜lesson部分
      #lessons1 = Lesson.where(
      #  "title like ? OR goal_knowledge like ? OR goal_ability like ? OR goal_emotion like ? OR unit_emphasis like ? OR \
      #  teaching_emphasis like ? OR teaching_difficulty like ? OR teaching_method like ? OR teaching_ready like ? OR    \
      #  course like ? OR grade like ? OR volume like ? OR unit like ? OR class_hour like ?", 
      #  search_str, search_str, search_str, search_str, search_str, search_str, search_str, search_str, search_str, search_str, 
      #  search_str, search_str, search_str, search_str
      #)
      # 其实简单搜就好
      lessons1 = Lesson.where("title like ? OR course like ? OR grade like ?", search_str, search_str, search_str)
    
      # 搜lesson_hour部分
      #lessons2 = Lesson.joins(:lesson_hours).where(
      #  "lesson_hours.process_teacher like ? OR lesson_hours.process_stu like ? OR lesson_hours.process_idea like ? OR  \
      #  lesson_hours.evaluate_blackboard like ? OR lesson_hours.summary_homework like ? OR lesson_hours.thinking like ?", 
      #  search_str, search_str, search_str, search_str, search_str, search_str
      #)
      
      # 搜作者
      lessons3 = []
      User.where("username LIKE ?", search_str).each do |user|
        lessons3 = user.lessons
      end
    
      @lessons = (lessons1 + lessons3).uniq.sort { |x, y| y.created_at <=> x.created_at } # 要uniq并且按时间排序
      @search_str = params[:search_str]
    else
      @lessons = Lesson.all
      @search_str = params[:search_str]
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
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

    if params[:flag].blank?
      #ids = @lesson.user.lessons.pluck(:id)                                           # 用户自己的备课
      @next = Lesson.unscoped.where(:user_id => current_user.id).where('id > ?', params[:id]).first
      @prev = Lesson.unscoped.where(:user_id => current_user.id).where('id < ?', params[:id]).last
    else
      if -1 == params[:flag].to_i
        #ids = Lesson.where(:course => Lesson::COURSES[3..-1]).pluck(:id)              # 综合科所有科目
        @next = Lesson.unscoped.where('id > ?', params[:id]).where(:course => Lesson::COURSES[3..-1]).first
        @prev = Lesson.unscoped.where('id < ?', params[:id]).where(:course => Lesson::COURSES[3..-1]).last
      else
        #ids = Lesson.where(:course => Lesson::COURSES[params[:flag].to_i]).pluck(:id) # 指定科目
        @next = Lesson.unscoped.where('id > ?', params[:id]).where(:course => Lesson::COURSES[params[:flag].to_i]).first
        @prev = Lesson.unscoped.where('id < ?', params[:id]).where(:course => Lesson::COURSES[params[:flag].to_i]).last
      end
    end
    
    #i = ids.index(params[:id].to_i)
    #@next_lesson = ids.first == params[:id].to_i ? nil : Lesson.find(ids[i-1])
    #@prev_lesson = ids.last == params[:id].to_i ? nil : Lesson.find(ids[i+1])
    
    # 兼容旧格式, WTF!!!
    tpl = 'show_lesson_new.html.erb'
    if @lesson.created_at < Time.new('2012','9','1')
      tpl = 'show_lesson_old.html.erb'
    elsif @lesson.created_at < Time.new('2012','10','4')
      tpl = 'show_lesson.html.erb'
    end

    respond_to do |format|
      format.html { render tpl}# show.html.erb
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
        format.html { redirect_to myhome_path, notice: '创建成功' } if logged_in?
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
        format.html { redirect_to myhome_path, notice: '更新成功' } if logged_in?
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
      format.html { redirect_to myhome_path, notice: '删除成功' } if logged_in?
      format.html { redirect_to lessons_url, notice: '删除成功' } if not logged_in?
    end
  end
end
