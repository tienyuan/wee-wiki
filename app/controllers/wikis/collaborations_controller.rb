class Wikis::CollaborationsController < ApplicationController

  def show
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaboration = Collaboration.find(params[:id])
  end

  # def new
  #   puts "i am in new"
  #   @wiki = Wiki.friendly.find(params[:wiki_id])
  #   authorize @collaboration
  # end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaboration = @collaboration.new(collab_params)
    authorize @collaboration
    if @collaboration.save
      redirect_to @wiki, notice: "Collaborator added!"
    else
      flash[:error] = "Collaborator failed. Please try again."
      render :new
    end
  end

end
