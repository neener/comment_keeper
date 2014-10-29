class UsersController < ApplicationController

 def index
 	users = User.all()
 	categories = Category.all()
 	render(:index, {locals: {categories: categories}})
 end

 def create
 	user = User.create(email: params["email"], password: params["password"])
 end

 def show
 	user = User.find(params[:id])
 end

 def update
 	user = User.find(params[:id])
 	user.email = params["email"]
 	user.password = params["password"]
 end

 def destroy
 	user = User.find(params[:id])
 	user.destroy()
 end

end