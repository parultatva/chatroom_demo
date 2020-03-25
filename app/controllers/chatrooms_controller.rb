class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]
  # skip_before_action :doorkeeper_authorize!, only: [ :index ]

  # GET /chatrooms
  # GET /chatrooms.json
  def index
    @chatrooms = Chatroom.public_channels
    render :json => @chatrooms
  end

  # GET /chatrooms/1
  # GET /chatrooms/1.json
  def show
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    puts "=====#{current_user.inspect}======"
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    render :json => @messages
  end

  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms
  # POST /chatrooms.json
  def create
    @chatroom = Chatroom.new(chatroom_params)
    respond_to do |format|

      if @chatroom.save
        @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
        msg = { :status => "ok", :message => "Success!", :html => "Chatroom was successfully created." }
        # format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
        # format.json { render :show, status: :created, location: @chatroom }
        format.json  { render :json => msg }
      else
        # format.html { render :new }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chatrooms/1
  # PATCH/PUT /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        # format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
        # format.json { render :show, status: :ok, location: @chatroom }
        msg = { :status => "ok", :message => "Success!", :html => "Chatroom was successfully updated." }
        format.json  { render :json => msg }
      else
        # format.html { render :edit }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy
    respond_to do |format|
      # format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
      # format.json { head :no_content }
      msg = { :status => "ok", :message => "Success!", :html => "Chatroom was successfully destroyed." }
      format.json  { render :json => msg }
    end
  end

  def joins_channel
    @chatrooms = current_user.chatrooms.public_channels
    render :json => @chatrooms
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chatroom_params
      params.require(:chatroom).permit(:name)
    end
end
