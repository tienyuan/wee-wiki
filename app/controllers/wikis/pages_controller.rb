class Wikis::PagesController < ApplicationController

  def show
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = @wiki.pages.new(page_params)
    if @page.save
      redirect_to [@wiki, @page], notice: "Page added!"
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
