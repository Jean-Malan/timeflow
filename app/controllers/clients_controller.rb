class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :to_do]
  before_action :authenticate_user!

  # GET /clients
  # GET /clients.json
  def index
    @cards = Card.all.where(user_id: current_user.id)
    @tags = Tag.all.where(user_id: current_user.id)
    @time_cards = TimeCard.all.where(user_id: current_user.id)
    @listings = Listing.all.where(user_id: current_user.id)
    @clients = Client.all.where(user_id: current_user.id)
  end
  
  # GET /clients/1
  # GET /clients/1.json
  def show
    @tags = Tag.all.where(user_id: current_user.id)
    @time_cards = TimeCard.all.where(user_id: current_user.id)
    @listings = Listing.all.where(client_id: @client.id).where(user_id: current_user.id)
  end

  def to_do
    @cards = Card.all.where(client_id: params[:id]).where(user_id: current_user.id)
    @tags = Tag.all.where(user_id: current_user.id)
    @time_cards = TimeCard.all.where(user_id: current_user.id)
    @listings = Listing.all.where(client_id: @client.id).where(user_id: current_user.id)
  end

  # GET /clients/new
  def new
    @client = Client.new
    @client.user_id = current_user.id
  end
  
  # GET /clients/1/edit
  def edit
  end
  
  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :address)
    end
end
