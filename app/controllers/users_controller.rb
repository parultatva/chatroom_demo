class UsersController < ApplicationController
	def index
		@users = User.where.not(id: current_user.try(:id))
		render :json => @users
	end
end
