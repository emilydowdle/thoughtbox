class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    links = Link.all
    respond_with links
  end

  def update
    link = Link.find(params[:id])
    link.update(link_params)
    respond_with link, json: link
  end

  private

  def link_params
    # binding.pry
    params.permit(:id, :title, :url, :read)
  end
end
