class ApplicationsController < ApplicationController
  before_action :check_profile, if: :applying_for_job?, only: [:show, :new, :create, :edit, :update]

  def new

  end

  def create

  end

  private

  def check_profile
    if current_candidate.profile
      current_candidate.profile.attributes.each do |elem|
        elem[1].blank?
        return false
      end
    else
      redirect_to new_profile_path, alert: 'Vocẽ deve possuir um perfil para aplicar à vaga'
    end
  end

  def applying_for_job?
    redirect_to edit_profile_path(current_candidate.profile), alert: 'Preencha seu perfil para aplicar à vaga!' unless check_profile
  end
end