class Wikis::CollaborationsController < ApplicationController

  def show
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaboration = Collaboration.find(params[:id])
  end

  def create
    @email = params[:user][:email]
    @user = User.where(email: @email).first if @email
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaboration = Collaboration.new(wiki: @wiki, user: @user) if @user 
    
    authorize @collaboration if @collaboration

    if @collaboration
      @collaboration.save
      redirect_to @wiki, notice: "Collaborator added!"
    else
      flash[:error] = "Collaborator failed. Please try again."
      redirect_to @wiki
    end
  end
end
