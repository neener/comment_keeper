require 'google/api_client'
require 'httparty'

class Comment < ActiveRecord::Base
	belongs_to :category

	@@youtube = false
	@@client = false

	def Comment.populate(video_id, video_list=[])
		Comment.new_session if !@@youtube || !@@client
		
		result = @@client.execute(
		  :api_method => @@youtube.search.list,
		  :parameters => {'part' => 'id', 'type' => 'video', 'relatedToVideoId' => video_id}
		)

		#results are in result.response.body which has to be converted from JSON to a hash
		#push ids into video_list

		new_result = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{video_id}/comments?max-results=50&alt=json&orderby=published")

		Comment.populate(video_list.pop, video_list) unless video_list.empty?
	end

	def Comment.new_session
		@@client = Google::APIClient.new(
			:key => "AIzaSyA8pMwXcOs1vhJW_oTElDlNwltNnq_E-qY",
			:authorization => nil
		)
		@@youtube = @@client.discovered_api('youtube', 'v3');
	end


end
