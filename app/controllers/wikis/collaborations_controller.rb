class Wikis::CollaborationsController < ApplicationController

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

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @user = User.find(params[:id])
    @collaboration = Collaboration.where(wiki: @wiki, user: @user).first

    authorize @collaboration
    if @collaboration.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @wiki
    else
      flash[:error] = "Removal failed. Please try again."
      redirect_to @wiki
    end
  end
end
