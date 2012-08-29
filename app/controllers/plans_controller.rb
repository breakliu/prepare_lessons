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

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    if logged_in?
      ids = @plan.user.plans.pluck(:id)
    else
      ids = Plan.pluck(:id)
    end

    i = ids.index(params[:id].to_i)
    @next_plan = ids.first == params[:id].to_i ? nil : Plan.find(ids[i-1])
    @prev_plan = ids.last == params[:id].to_i ? nil : Plan.find(ids[i+1])

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
        format.html { redirect_to @plan, notice: '教学计划创建成功' }
        format.json { render json: plans_path, status: :created, location: @plan }
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
end
