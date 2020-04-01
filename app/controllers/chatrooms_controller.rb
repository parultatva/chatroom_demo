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
    # render :json => @messages
    render json: @chatroom, include: 'messages,messages.attachments'
    # json_response({
    #   success: true,
    #   data: {
    #     chatroom: ActiveModelSerializers::SerializableResource.new(@chatroom,serializer: ChatroomSerializer),
    #   }
    # }, 200)

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
    if @chatroom.save
      @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
      msg = { :status => "ok", :data => @chatroom, :message => "Success!", :html => "Chatroom was successfully created." }
      # format.html { redirect_to @chatroom, notice: 'Chatroom was successfully created.' }
      # format.json { render :show, status: :created, location: @chatroom }
      # format.json  { render :json => msg }
      render :json => msg
    else
      # format.html { render :new }
      # format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      msg = { status: :unprocessable_entity, :json => @chatroom.errors }
      render :json => msg
    end
  end

  # PATCH/PUT /chatrooms/1
  # PATCH/PUT /chatrooms/1.json
  def update
    if @chatroom.update(chatroom_params)
      # format.html { redirect_to @chatroom, notice: 'Chatroom was successfully updated.' }
      # format.json { render :show, status: :ok, location: @chatroom }
      msg = { :status => "ok", :data => @chatroom, :message => "Success!", :html => "Chatroom was successfully updated." }
      render :json => msg
    else
      # format.html { render :edit }
      msg = { status: :unprocessable_entity, :json => @chatroom.errors }
      render :json => msg
    end
  end

  # DELETE /chatrooms/1
  # DELETE /chatrooms/1.json
  def destroy
    @chatroom.destroy
      # format.html { redirect_to chatrooms_url, notice: 'Chatroom was successfully destroyed.' }
      # format.json { head :no_content }
      msg = { :status => "ok", :message => "Success!", :html => "Chatroom was successfully destroyed." }
      render :json => msg
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
