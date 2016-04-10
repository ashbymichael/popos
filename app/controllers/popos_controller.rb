class PoposController < ApplicationController
  include ApplicationHelper

  def welcome
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
  end
end
