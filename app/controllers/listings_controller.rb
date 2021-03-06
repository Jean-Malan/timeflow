class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :move, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.where(user_id: current_user.id)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @time_cards = TimeCard.all.where(user_id: current_user.id)
    @tags = Tag.all.where(user_id: current_user.id)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @listing.user_id = current_user.id
    
  end
  
  def move
    @listing.insert_at(listing_params[:position].to_i)
    render action: :show
  end
  
  # GET /listings/1/edit
  def edit
  end
  
  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params.merge(user_id: current_user.id))
    
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :position, :listing, :id, :client_id, :user_id)
    end
end
