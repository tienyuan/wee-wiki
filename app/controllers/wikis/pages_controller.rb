class Wikis::PagesController < ApplicationController

  def show
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
  end

  def new
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.new
    authorize @page
  end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = @wiki.pages.new(page_params)
    authorize @page
    if @page.save
      redirect_to [@wiki, @page], notice: "Page added!"
    else
      flash[:error] = "Page failed. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page
  end

  def update
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    @page.slug = nil
    authorize @page
    if @page.update_attributes(page_params)
      redirect_to [@wiki, @page], notice: "Page edited!"
    else
      flash[:error] = "Page edit failed. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @page = Page.friendly.find(params[:id])
    authorize @page

    if @page.destroy
      redirect_to @wiki, notice: "Page deleted!"
    else
      flash[:error] = "Page delete failed. Please try again."
      redirect_to [@wiki, @page]
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body) 
  end
end
