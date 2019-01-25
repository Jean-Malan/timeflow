class TimeCardsController < ApplicationController
  before_action :set_time_card, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /time_cards
  # GET /time_cards.json
  def index
    @time_cards = TimeCard.all.where(user_id: current_user.id)
    @clients = Client.all.where(user_id: current_user.id)
    @cards = Card.all.where(user_id: current_user.id)
    @tags = Tag.all.where(user_id: current_user.id)
    @time_card_date= []
    TimeCard.all.where(user_id: current_user.id).map{|x| @time_card_date.push(x.created_at.strftime("%Y-%m-%d")) }
    @time_card_date = @time_card_date.uniq.reverse!
  end

  # GET /time_cards/1
  # GET /time_cards/1.json
  def show
  end

  def list

  end

  # GET /time_cards/new
  def new
    @time_card = TimeCard.new
    @time_card.user_id = current_user.id
  end
  
  # GET /time_cards/1/edit
  def edit
  end
  
  # POST /time_cards
  # POST /time_cards.json
  def create
    @time_card = TimeCard.new(time_card_params)
    @time_card.user_id = current_user.id
    @time_card.total_time = @time_card.format_time(time_card_params[:recorded_time])

    respond_to do |format|
      if @time_card.save
        format.html { redirect_to @time_card, notice: 'Time card was successfully created.' }
        format.json { render :show, status: :created, location: @time_card }
      else
        format.html { render :new }
        format.json { render json: @time_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_cards/1
  # PATCH/PUT /time_cards/1.json
  def update
    respond_to do |format|
      if @time_card.update(time_card_params)
        format.html { redirect_to @time_card, notice: 'Time card was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_card }
      else
        format.html { render :edit }
        format.json { render json: @time_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_cards/1
  # DELETE /time_cards/1.json
  def destroy
    @time_card.destroy
    respond_to do |format|
      format.html { redirect_to time_cards_url, notice: 'Time card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_card
      @time_card = TimeCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_card_params
      params.require(:time_card).permit(:description, :total_time, :recorded_time, :time, :date, :client_id, :card_id, :tag_id, :start_time, :end_time)
    end
end
