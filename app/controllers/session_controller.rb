class SessionController < ApplicationController

	def new
	
	end

	def create
		user = User.find_by(email: params[:email])
		# binding.pry
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/comments'
		else
			redirect_to '/'
		end
	end

	def destroy
		reset_session
		redirect_to '/'
	end

end