class WikisController < ApplicationController
  before_filter :require_login, except: [:index, :show]

  def create
    @wiki = current_user.wikis.new
    @wiki.save!

    params[:id] = @wiki.id
    render :show
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def index
    @wikis = Wiki.all
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes!(wiki_params)

    respond_to do |format|
      format.json { respond_with_bip(@wiki) }
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:success] = "\"#{@wiki.name}\" has been deleted"
      redirect_to root_path
    else
      flash[:alert] = "On snap! There was a problem deleting \"#{@wiki.name}\""
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:name)
  end
end
