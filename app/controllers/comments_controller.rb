class CommentsController < ApplicationController

def index
	# comments = Comment.all()
	render :index
end

def create
	comment = Comment.create(text: params["text"])
end

def show
	comment = Comment.find(params[:id])
end

def update
	comment = Comment.find(params[:id])
end

def destroy
	comment = Comment.find(params[:id])
	comment.destroy()
end

end