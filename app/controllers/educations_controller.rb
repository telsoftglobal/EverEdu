class EducationsController < ApplicationController
  layout 'default'
  before_action :authenticate
  before_action :set_education, only: [:show, :edit, :update, :destroy]

  # GET /educations
  # GET /educations.json
  def index
    user_id = session[:user_id]
    @educations = Education.where(user_id: user_id).order_by(created_at: -1)
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
    if @education.nil?
      flash.now[:error] = t('educations.msg_education_not_found')
      respond_to do |format|
        format.js { render action: 'edit_fail', :not_found => true }
      end
    end
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = Education.new(education_params)
    @education.user_id = session[:user_id]

    respond_to do |format|
      if @education.save
        flash.now[:notice] = t('educations.msg_create_successfully')
        format.html { redirect_to @education, notice: t('educations.msg_create_successfully') }
        format.json { render :show, status: :created, location: @education }
        format.js
      else
        if @education.errors
          flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
        else
          flash.now[:error] = t('educations.msg_create_fail')
        end
        format.html { render :new }
        format.json { render json: @education.errors, status: :unprocessable_entity }
        format.js { render action: 'create_fail' }
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    if @education.nil?
      flash.now[:error] = t('educations.msg_education_not_found')
      respond_to do |format|
        format.js { render action: 'update_fail' }
      end
    else
      respond_to do |format|
        if @education.update(education_params)
          format.html { redirect_to @education, notice: t('educations.msg_update_successfully')}
          format.json { render :show, status: :ok, location: @education }
          format.js
        else
          if @education.errors
            flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
          else
            flash.now[:error] = t('educations.msg_update_fail')
          end
          format.html { render :edit }
          format.json { render json: @education.errors, status: :unprocessable_entity }
          format.js { render action: 'update_fail' }
        end
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    if @education.nil?
      flash.now[:error] = t('educations.msg_education_not_found')
      respond_to do |format|
        format.js {render action: 'destroy_fail'}
      end
    else
      if @education.destroy
        respond_to do |format|
          format.html { redirect_to educations_url, notice: t('educations.msg_delete_successfully') }
          format.json { head :no_content }
          format.js
        end
      else
        if @education.errors
          flash.now[:error] = @education.errors.full_messages.to_sentence(:last_word_connector => ', ');
        else
          flash.now[:error] = t('educations.msg_update_fail')
        end

        respond_to do |format|
          format.js {render action: 'destroy_fail'}
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      @education = Education.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def education_params
      if params[:education][:school_name]
        params[:education][:school_name] = params[:education][:school_name].strip
      end

      if params[:education][:description]
        params[:education][:description] = params[:education][:description].strip
      end
      params.require(:education).permit(:school_name, :start_year, :end_year, :current, :description)
    end
end
