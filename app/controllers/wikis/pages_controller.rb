class Wikis::PagesController < ApplicationController

  def show
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
  end

  def create
    @page = @wiki.pages.new(page_params)
    
    if @page.save
      redirect_to @page
      flash[:notice] = "Page created!"
    else
      flash[:error] = "Page failed. Please try again."
      render :new
    end
  end

  def edit
  end

  private

  def page_params
    params.require(:page).permit(:title, :body) 
  end
end
