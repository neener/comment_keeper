require 'google/api_client'
require 'httparty'

class Comment < ActiveRecord::Base
	belongs_to :category
	belongs_to :video

	@@youtube = false
	@@client = false

	def Comment.populate(video_id)
		Comment.new_session if !@@youtube || !@@client
		
		result = @@client.execute(
		  :api_method => @@youtube.search.list,
		  :parameters => {'part' => 'id', 'type' => 'video', 'relatedToVideoId' => video_id}
		)

		#results are in result.response.body which has to be converted from JSON to a hash
		#push ids into video_list

		items = JSON.parse(result.body)["items"]
		#items && items.each do |item|
			item = items.first
			vidId = item["id"]["videoId"]
			vid = Video.create(youtube_video_id: vidId)
			new_result = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{vidId}/comments?alt=json&max-results=50&alt=json&orderby=published")
			
			comments = new_result["feed"]["entry"]
			comments && comments.each do |comment_hash|
				comment_text = comment_hash["content"]["$t"]
				Comment.create(video_id: vid.id, text: comment_text)
			end
		#end

		Comment.populate(vidId)


		#binding.pry
		#http://gdata.youtube.com/feeds/api/videos/DBNYwxDZ_pA/comments?orderby=published&alt=json&max-results=30&start-index=1
		#Comment.populate(video_list.pop, video_list) unless video_list.empty?
	end

	def Comment.new_session
		@@client = Google::APIClient.new(
			:key => "AIzaSyA8pMwXcOs1vhJW_oTElDlNwltNnq_E-qY",
			:authorization => nil
		)
		@@youtube = @@client.discovered_api('youtube', 'v3');
	end


end
