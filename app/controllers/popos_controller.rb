class PoposController < ApplicationController
  def welcome
  end

  def upload
  end

  def import
    Popo.import(params[:file])
    flash[:success] = "Popos uploaded"
    redirect_to root_url
  end
end
