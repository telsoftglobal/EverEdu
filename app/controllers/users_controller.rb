class UsersController < ApplicationController
  layout 'default'

  before_action :authenticate

  def about
    @user = User.find(params[:id])

    if @user.nil?
      flash[:error] = t('users.msg_user_not_found')
      redirect_to home_error_path
    end

  end

  def show

  end

  def send_mail
    begin
        email = params[:email]
        name =  params[:name]

        respond_to do |format|
          if Emailer.send_email(email,name).deliver
            format.html { render :show,notice: 'send mail success !' }
            format.json { render :show, status: :created, location: @aes_action }
          else
            format.html { render :show }
            # format.json { render json: @aes_action.errors, status: :unprocessable_entity }
          end
        end
    rescue Exception => e
        logger.error("update_curriculum_detail error: #{e.message}")
        puts e.message
        respond_to do |format|
          flash.now[:error] = 'send mail failed'
          format.html { render :show }
          # format.json { render json: @aes_action.errors, status: :unprocessable_entity }
        end
    end
  end

  def changepassword
    if request.method == 'GET'
      respond_to do |format|
        format.html
      end
    else
      begin



        current_password = params[:current_password]
        password =  params[:password]
        confirm_password =  params[:confirm_password]
        if user = User.find_by(:id => session[:user_id])
          if !user.nil?
            respond_to do |format|
              if user.hashed_password == User.encrypt_password(current_password, user.salt) && password == confirm_password
                if user.update_attribute(:hashed_password, User.encrypt_password(password, user.salt))
                  Emailer.send_email_change_password(user).deliver
                  format.html { render notice: 'send mail success !' }
                else
                  flash.now[:error] = 'error when update'
                  format.html
                end
              else
                flash.now[:error] = 'wrong info'
                format.html
              end
            end
          end
        end
      rescue Exception => e
        logger.error("change password error: #{e.message}")
        puts e.message
        respond_to do |format|
          flash.now[:error] = 'change password failed'
          format.html
          # format.json { render json: @aes_action.errors, status: :unprocessable_entity }
        end
      end
    end

  end

end
