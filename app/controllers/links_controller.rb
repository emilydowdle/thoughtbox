class LinksController < ApplicationController
  def index
    @link = current_user.links.new
    @links = current_user.links.all
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to root_path
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to root_path
    end
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    if @link.save
      redirect_to root_path
    else
      flash[:error] = "Something went wrong. Try again."
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:title,
                                 :url,
                                 :read,
                                 :id)
  end
end
