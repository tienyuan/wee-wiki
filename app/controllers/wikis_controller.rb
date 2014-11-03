class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update]

  def index
    @wikis = Wiki.viewable_wikis(current_user)
  end

  def show
    authorize @wiki
    @pages = @wiki.pages
    @collaborations = @wiki.users
    @collaboration = Collaboration.new
  end

  def new
    @subscription = Subscription.DEFAULT / 100
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :description, :private))
    @wiki.owner = current_user
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created!"
    else
      flash[:error] = "Wiki failed. Please try again."
      render :new
    end
  end

  def edit
    authorize @wiki
  end

  def update
    reset_wiki_slug
    authorize @wiki
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :description, :private)) 
      redirect_to @wiki, notice: "Wiki edited!"
    else
      flash[:error] = "Wiki edit failed. Please try again."
      render :edit
    end
  end

  private

  def set_wiki
    @wiki = Wiki.friendly.find(params[:id])
  end

  def reset_wiki_slug
    @wiki.slug = nil
  end
end
