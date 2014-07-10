class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
	
  # error message for feeds not belonging to a user
  def err_mex 
    flash.now[:notice] = "Non sei il possessore di questo feed e non detieni i privilegi per alterarlo!" 			
    render "show"
  end
# err_mex end #
		

  # GET /feeds
  def index
    @feeds = Feed.all
  end
# index end #


  # GET /feeds/1
  def show
  end
# show end #


  # GET /feeds/new
  def new
    @feed = Feed.new
  end
# new end #


  # GET /feeds/1/edit
  def edit
    if @feed.user_id != current_user.id
      err_mex 
    elsif@feed.date <= DateTime.now.utc
      flash[:notice] = "Non puoi modificare feed gia' pubblicati"
      redirect_to action: 'index' 
    end
  end 
# edit end #


  # POST /feeds
  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id 		

    respond_to do |format|
      if @feed.save
        flash[:notice] = 'Il Feed e\' stato creato con successo'
        format.html { redirect_to action: 'index' }
      else
        format.html { render action: 'new' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end
# create end #


  # PATCH/PUT /feeds/1
  def update
    if @feed.user_id == current_user.id
      respond_to do |format|
        if @feed.update(feed_params)
          flash[:notice] = 'Il Feed e\' stato aggiornato con successo'
          format.html { redirect_to action: 'index' }
        else
          format.html { render action: 'edit' }
          format.json { render json: @feed.errors, status: :unprocessable_entity }
        end
      end
    else
      err_mex
    end
  end	
# update end #
 

  # DELETE /feeds/1
  def destroy
    if @feed.user_id == current_user.id
      @feed.destroy
      respond_to do |format|
        format.html { redirect_to feeds_url }
        format.json { head :no_content }
        end
    else
      err_mex
    end
  end	
# destroy end #


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end
# set_feed end #


    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:feed_text, :date, :feed_image)
    end
# feed_params end #
end
