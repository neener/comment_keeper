class CategoriesController < ApplicationController

	def index
		categories = Category.all()
	end

	def create
		category = Category.create(name: params["name"])
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