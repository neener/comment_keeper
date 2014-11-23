class SearchController < ApplicationController

	def search_comments
		@comments = Comment.where('text LIKE ?', "%#{params[:query][:comments]}%")
		unless @comments.empty?
			render "comments/index"
		end
	end
end
