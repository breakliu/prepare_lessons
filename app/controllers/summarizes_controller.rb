# coding: utf-8
class SummarizesController < ApplicationController
  # GET /summarizes
  # GET /summarizes.json
  def index
    @summarizes = Summarize.where(:user_id => current_user.id).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summarizes }
    end
  end

  def summarize_list
    @summarizes = Summarize.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summarizes }
    end
  end

  # GET /summarizes/1
  # GET /summarizes/1.json
  def show
    @summarize = Summarize.find(params[:id])

    if logged_in?
      ids = @summarize.user.summarizes.pluck(:id)
    else
      ids = Summarize.pluck(:id)
    end

    i = ids.index(params[:id].to_i)
    @next_summarize = ids.first == params[:id].to_i ? nil : Summarize.find(ids[i-1])
    @prev_summarize = ids.last == params[:id].to_i ? nil : Summarize.find(ids[i+1])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @summarize }
    end
  end

  # GET /summarizes/new
  # GET /summarizes/new.json
  def new
    @summarize = Summarize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @summarize }
    end
  end

  # GET /summarizes/1/edit
  def edit
    @summarize = Summarize.find(params[:id])
  end

  # POST /summarizes
  # POST /summarizes.json
  def create
    @summarize = Summarize.new(params[:summarize])
    @summarize['user_id'] = current_user.id

    respond_to do |format|
      if @summarize.save
        format.html { redirect_to summarizes_path, notice: '教学总结创建成功' }
        format.json { render json: @summarize, status: :created, location: @summarize }
      else
        format.html { render action: "new" }
        format.json { render json: @summarize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /summarizes/1
  # PUT /summarizes/1.json
  def update
    @summarize = Summarize.find(params[:id])

    respond_to do |format|
      if @summarize.update_attributes(params[:summarize])
        format.html { redirect_to summarizes_path, notice: '教学总结更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @summarize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /summarizes/1
  # DELETE /summarizes/1.json
  def destroy
    @summarize = Summarize.find(params[:id])
    @summarize.destroy

    respond_to do |format|
      format.html { redirect_to summarizes_url }
      format.json { head :no_content }
    end
  end

  def summarize_search
    @users = User.all
    @terms = Term.all
    str = {}
    if not params[:term_id].blank?
      str[:term_id] = params[:term_id]
    else
      str[:term_id] = Term.first
    end
    str[:user_id] = params[:user_id] if not params[:user_id].blank?
    @summarizes = Summarize.where(str);

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summarizes }
    end
  end
end
