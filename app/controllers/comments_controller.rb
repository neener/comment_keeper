class CommentsController < ApplicationController

def index
	@comments = Comment.all
end

def create
	video_id = params[:video_id]
	vid = Video.where(youtube_video_id: vidId).first_or_create
	results = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{video_id}/comments?max-results=50&alt=json&orderby=published")
	results["feed"]["entry"].each do |comment_hash|
		comment_text = comment_hash["content"]["$t"]
		comment_id = comment_hash["id"]["$t"].split("/")[-1]
		Comment.create(text: comment_text, video_id: vid.id, youtube_comment_id: comment_id)
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