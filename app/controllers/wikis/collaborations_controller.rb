class Wikis::CollaborationsController < ApplicationController
  before_action :set_wiki

  def create
    @email = params[:user][:email]
    @user = User.where(email: @email).first if @email

    authorize @collaboration if set_collaboration

    if @collaboration
      @collaboration.save
      redirect_to @wiki, notice: 'Collaborator added!'
    else
      flash[:error] = 'Collaborator failed. Please try again.'
      redirect_to @wiki
    end
  end

  def destroy
    @user = User.find(params[:id])
    @collaboration = Collaboration.where(wiki: @wiki, user: @user).first

    authorize @collaboration
    if @collaboration.destroy
      redirect_to @wiki, notice: 'Collaborator removed.'
    else
      flash[:error] = 'Removal failed. Please try again.'
      redirect_to @wiki
    end
  end

  private

  def set_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end

  def set_collaboration
    if @user && !Collaboration.exists?(wiki: @wiki, user: @user)
      @collaboration = Collaboration.new(wiki: @wiki, user: @user)
    end
  end
end
