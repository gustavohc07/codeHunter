class JobsController < ApplicationController
  before_action :authenticate_headhunter!, only: [:show, :new, :create, :edit, :update, :destroy]


  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end
end