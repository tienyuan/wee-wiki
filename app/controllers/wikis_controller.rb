class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    
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
