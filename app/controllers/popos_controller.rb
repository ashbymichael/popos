class PoposController < ApplicationController
  include ApplicationHelper

  def welcome
    @popos = Popo.all.page(params[:page])
  end

  def upload
  end

  def import
    Popo.import(params[:file])
    flash[:success] = "Popos uploaded"
    redirect_to root_url
  end

  def search
  end

  def index
    @popos = sort_popos_by_distance
    p "*" * 100
    p @popos

  end

  def map_markers
    @popos = Popo.all
    respond_to do |format|
        format.html { redirect_to @popos, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render json: @popos }
    end
  end
end
