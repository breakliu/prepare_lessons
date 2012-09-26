# coding: utf-8
class PlansController < ApplicationController
  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.where(:user_id => current_user.id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  def plan_list
    @plans = Plan.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    @next = Plan.unscoped.where('id > ?', params[:id]).first
    @prev = Plan.unscoped.where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  def show_plans_personal
    @plan = Plan.find(params[:id])

    @next = Plan.unscoped.where(:user_id => current_user.id).where('id > ?', params[:id]).first
    @prev = Plan.unscoped.where(:user_id => current_user.id).where('id < ?', params[:id]).last

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(params[:plan])
    @plan['user_id'] = current_user.id

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_path, notice: '教学计划创建成功' }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to plans_path, notice: '教学计划更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

  def plan_search
    @users = User.all
    @terms = Term.all
    str = {}
    if not params[:term_id].blank?
      str[:term_id] = params[:term_id]
    else
      str[:term_id] = Term.first
    end
    str[:user_id] = params[:user_id] if not params[:user_id].blank?
    str[:course] = params[:course] if not params[:course].blank?
    str[:grade] = params[:grade] if not params[:grade].blank?
    @plans = Plan.where(str);

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end
end
