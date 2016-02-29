class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    links = Link.order
    respond_with links
  end

  def show
    respond_with Link.find(idea_params[:id])
  end

  def create
    idea = Link.new(idea_params)
    idea.save
    respond_with :api, :v1, idea
  end

  def update
    idea = Link.find(idea_params[:id])
    idea.update(idea_params)
    respond_with idea, json: idea
  end

  def destroy
    idea = Link.find(idea_params[:id])
    idea.destroy
    respond_with :api, :v1, idea
  end

  private

  def link_params
    params.permit(:id, :title, :url, :read)
  end
end
