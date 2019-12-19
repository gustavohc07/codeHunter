class ProfilesController < ApplicationController
  before_action :authenticate_candidate!

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      flash[:notice] = 'Perfil criado com sucesso!'
      redirect_to @profile
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:image, :name, :last_name,
                                    :social_name, :birthday, :about_yourself,
                                    :university, :graduation_course,
                                    :year_of_graduation, :company, :role,
                                    :start_date, :end_date, :experience_description)
  end
end