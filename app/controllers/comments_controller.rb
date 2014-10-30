class CommentsController < ApplicationController

def index
	
	if params[:query].present?
		
		@comments = Comment.where('text LIKE ?', "%#{params[:query][:comments]}%")
	else
		@comments = Comment.all
		# render :index
	# end
end
end

def create
	video_id = params[:video_id]
	results = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{video_id}/comments?max-results=50&alt=json&orderby=published")
	results["feed"]["entry"].each do |comment_hash|
		comment_text = comment_hash["content"]["$t"]
		Comment.create(text: comment_text)
	end
	redirect_to '/comments'
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