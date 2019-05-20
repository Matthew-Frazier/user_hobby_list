class HobbiesController < ApplicationController
  before_action :set_hobby, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    current_user.hobbies
  end

  def show
  end

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = current_user.hobbies.new(hobby_params)
    if @hobby.save
      flash[:success] = "#{@hobby.name} Created"
      redirect_to hobbies_path
    else
      flash[:error] = "Error: #{@hobby.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def edit
  end

  def update
    if @hobby.update(hobby_params)
      flash[:success] = "#{@hobby.name} Updated"
      redirect_to hobbies_path
    else
      flash[:error] = "Error: #{@hobby.errors.full_messages.join("\n")}"
      render :edit
    end
  end

  def destroy
    @hobby.destroy
    redirect_to hobbies_path
  end

  private
    def set_hobby
      @hobby = current_user.hobbies.find(params[:id])
    end

    def hobby_params
      params.require(:hobby).permit(:name)
    end

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
end
