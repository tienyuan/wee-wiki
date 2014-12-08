class Wikis::PagesController < ApplicationController
  before_action :set_wiki
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def show
    authorize @page
  end

  def new
    @page = @wiki.pages.new
    authorize @page
  end

  def create
    @page = @wiki.pages.new(page_params)
    authorize @page
    if @page.save
      redirect_to [@wiki, @page], notice: 'Page added!'
    else
      flash[:error] = 'Page failed. Please try again.'
      render :new
    end
  end

  def edit
    authorize @page
  end

  def update
    reset_page_slug
    authorize @page
    if @page.update_attributes(page_params)
      redirect_to [@wiki, @page], notice: 'Page edited!'
    else
      flash[:error] = 'Page edit failed. Please try again.'
      render :edit
    end
  end

  def destroy
    authorize @page

    if @page.destroy
      redirect_to @wiki, notice: 'Page deleted!'
    else
      flash[:error] = 'Page delete failed. Please try again.'
      redirect_to [@wiki, @page]
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body)
  end

  def set_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def reset_page_slug
    @page.slug = nil
  end
end
