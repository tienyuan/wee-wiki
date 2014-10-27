class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    @pages = @wiki.pages
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created!"
    else
      flash[:error] = "Wiki failed. Please try again."
      render :new
    end
  end

  def edit
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :description, :private) 
  end

  def set_user

  end

end
