# coding: utf-8
class GroupResearchWorkPlansController < ApplicationController
  # GET /group_research_work_plans
  # GET /group_research_work_plans.json
  def index
    @group_research_work_plans = GroupResearchWorkPlan.where(:user_id => current_user.id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_research_work_plans }
    end
  end

  def group_research_work_plan_list
    @group_research_work_plans = GroupResearchWorkPlan.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_research_work_plans }
    end
  end

  # GET /group_research_work_plans/1
  # GET /group_research_work_plans/1.json
  def show
    @group_research_work_plan = GroupResearchWorkPlan.find(params[:id])

    @next = GroupResearchWorkPlan.unscoped.where('id > ?', params[:id]).first
    @prev = GroupResearchWorkPlan.unscoped.where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_research_work_plan }
    end
  end

  def show_grwps_personal
    @group_research_work_plan = GroupResearchWorkPlan.find(params[:id])

    @next = GroupResearchWorkPlan.unscoped.where(:user_id => current_user.id).where('id > ?', params[:id]).first
    @prev = GroupResearchWorkPlan.unscoped.where(:user_id => current_user.id).where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_research_work_plan }
    end
  end

  # GET /group_research_work_plans/new
  # GET /group_research_work_plans/new.json
  def new
    @group_research_work_plan = GroupResearchWorkPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_research_work_plan }
    end
  end

  # GET /group_research_work_plans/1/edit
  def edit
    @group_research_work_plan = GroupResearchWorkPlan.find(params[:id])
  end

  # POST /group_research_work_plans
  # POST /group_research_work_plans.json
  def create
    @group_research_work_plan = GroupResearchWorkPlan.new(params[:group_research_work_plan])
    @group_research_work_plan['user_id'] = current_user.id

    respond_to do |format|
      if @group_research_work_plan.save
        format.html { redirect_to group_research_work_plans_path, notice: '新建科组教研工作计划成功' }
        format.json { render json: @group_research_work_plan, status: :created, location: @group_research_work_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @group_research_work_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_research_work_plans/1
  # PUT /group_research_work_plans/1.json
  def update
    @group_research_work_plan = GroupResearchWorkPlan.find(params[:id])

    respond_to do |format|
      if @group_research_work_plan.update_attributes(params[:group_research_work_plan])
        format.html { redirect_to group_research_work_plans_path, notice: '更新科组教研工作计划成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_research_work_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_research_work_plans/1
  # DELETE /group_research_work_plans/1.json
  def destroy
    @group_research_work_plan = GroupResearchWorkPlan.find(params[:id])
    @group_research_work_plan.destroy

    respond_to do |format|
      format.html { redirect_to group_research_work_plans_url }
      format.json { head :no_content }
    end
  end

  def group_research_work_plan_search
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
    @group_research_work_plans = GroupResearchWorkPlan.where(str);

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_research_work_plans }
    end
  end
end
