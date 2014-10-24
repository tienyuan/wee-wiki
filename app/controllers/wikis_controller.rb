class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.create(wiki_params)

    if @wiki.save
      redirect_to @wiki
      flash[:notice] = "Wiki created!"
    else
      flash[:error] = "I couldn't create your Wiki. Please try again."
      render[:new]
    end
  end

  def edit
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :description, :private) 
  end

end
