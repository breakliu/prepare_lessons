# coding: utf-8
class GroupStudyPlansController < ApplicationController
  # GET /group_study_plans
  # GET /group_study_plans.json
  def index
    @group_study_plans = GroupStudyPlan.where(:user_id => current_user.id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_study_plans }
    end
  end

  def group_study_plan_list
    @group_study_plans = GroupStudyPlan.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_study_plans }
    end
  end

  # GET /group_study_plans/1
  # GET /group_study_plans/1.json
  def show
    @group_study_plan = GroupStudyPlan.find(params[:id])

    @next = GroupStudyPlan.unscoped.where('id > ?', params[:id]).first
    @prev = GroupStudyPlan.unscoped.where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_study_plan }
    end
  end

  def show_gsps_personal
    @group_study_plan = GroupStudyPlan.find(params[:id])

    @next = GroupStudyPlan.unscoped.where(:user_id => current_user.id).where('id > ?', params[:id]).first
    @prev = GroupStudyPlan.unscoped.where(:user_id => current_user.id).where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_study_plan }
    end
  end

  # GET /group_study_plans/new
  # GET /group_study_plans/new.json
  def new
    @group_study_plan = GroupStudyPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_study_plan }
    end
  end

  # GET /group_study_plans/1/edit
  def edit
    @group_study_plan = GroupStudyPlan.find(params[:id])
  end

  # POST /group_study_plans
  # POST /group_study_plans.json
  def create
    @group_study_plan = GroupStudyPlan.new(params[:group_study_plan])
    @group_study_plan['user_id'] = current_user.id

    respond_to do |format|
      if @group_study_plan.save
        format.html { redirect_to group_study_plans_path, notice: '新建科组学习计划成功' }
        format.json { render json: @group_study_plan, status: :created, location: @group_study_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @group_study_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_study_plans/1
  # PUT /group_study_plans/1.json
  def update
    @group_study_plan = GroupStudyPlan.find(params[:id])

    respond_to do |format|
      if @group_study_plan.update_attributes(params[:group_study_plan])
        format.html { redirect_to group_study_plans_path, notice: '更新科组学习计划成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_study_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_study_plans/1
  # DELETE /group_study_plans/1.json
  def destroy
    @group_study_plan = GroupStudyPlan.find(params[:id])
    @group_study_plan.destroy

    respond_to do |format|
      format.html { redirect_to group_study_plans_url }
      format.json { head :no_content }
    end
  end

  def group_study_plan_search
    @users = User.all
    @terms = Term.all
    @groups = Group.all
    str = {}
    if not params[:term_id].blank?
      str[:term_id] = params[:term_id]
    else
      str[:term_id] = Term.first
    end
    str[:user_id] = params[:user_id] if not params[:user_id].blank?
    str[:group_id] = params[:group_id] if not params[:group_id].blank?
    @group_study_plans = GroupStudyPlan.where(str);

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_study_plans }
    end
  end
end
