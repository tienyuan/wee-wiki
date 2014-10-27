class Wikis::PagesController < ApplicationController

  def show
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
    puts "i am in show page"
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
    puts "i am in new"
  end

  def create
    puts "i am in create"
    @wiki = Wiki.find(params[:wiki_id])
    @page = page.build(page_params)
    @page.wiki = @wiki
    
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
