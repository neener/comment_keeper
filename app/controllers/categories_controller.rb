class CategoriesController < ApplicationController

	def index
		categories = Category.all()
	end

	def new
		# binding.pry
		category = Category.create(name: params["category"])
		redirect_to '/users'
	end

	def show
		category = Category.find(params[:id])
	end

	def update
		category = Category.find(params[:id])
	end

	def destroy
		category = Category.find(params[:id])
		category.destroy()
	end
end