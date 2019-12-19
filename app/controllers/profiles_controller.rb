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
    if @profile.save
      flash[:notice] = 'Perfil criado com sucesso!'
      redirect_to current_candidate.profile
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.update(profile_params)
    redirect_to current_candidate.profile
  end

  private

  def profile_params
    params.require(:profile).permit(:image, :name, :last_name,
                                    :social_name, :birthday, :about_yourself,
                                    :university, :graduation_course,
                                    :year_of_graduation, :company, :role,
                                    :start_date, :end_date, :experience_description,
                                    :candidate_id)
        .merge(candidate: current_candidate)
  end
end