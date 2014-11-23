require 'google/api_client'
require 'httparty'

class Video < ActiveRecord::Base
	validates :youtube_video_id, :presence => true, :uniqueness => true
	validates :title, :presence => true

	has_many :comments

	@@youtube = false
	@@client = false

	def populate_comments
		Video.new_session if !@@youtube || !@@client
		
			new_result = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{youtube_video_id}/comments?alt=json&max-results=50&alt=json&orderby=published")
			
			new_comments = new_result["feed"]["entry"]
			new_comments.each do |comment_hash|
				comment_text = comment_hash["content"]["$t"]
				comment_id = comment_hash["id"]["$t"].split("/")[-1]
				self.comments.create(text: comment_text, youtube_comment_id: comment_id)
			end
	end

	def Video.from_youtube_video_id(yt_id)
		vid = Video.where(:youtube_video_id => yt_id).first_or_initialize
		return vid if vid.persisted?
		# binding.pry
		video_info = HTTParty.get("https://gdata.youtube.com/feeds/api/videos/#{yt_id}?v=2&alt=json")
		video_hash = JSON.parse(video_info.body)["entry"]
		title = video_hash["title"]["$t"]
		vid.title = title
		vid.save 
		vid

	end

	def populate_related(depth=0)
		Video.new_session if !@@youtube || !@@client
		result = @@client.execute(
		  :api_method => @@youtube.search.list,
		  :parameters => {'part' => 'id', 'type' => 'video', 'relatedToVideoId' => self.youtube_video_id}
		)

		items = JSON.parse(result.body)["items"]
		items.each do |item|
			youtube_video_id = item["id"]["videoId"]
			vid = Video.from_youtube_video_id(youtube_video_id)
			vid.populate_comments
			unless depth == 0	
				vid.populate_related(depth - 1)
			end
		end
	end

	def Video.new_session
		@@client = Google::APIClient.new(
			:key => "AIzaSyA8pMwXcOs1vhJW_oTElDlNwltNnq_E-qY",
			:authorization => nil
		)
		@@youtube = @@client.discovered_api('youtube', 'v3');
	end

	def youtube_url
		"https://www.youtube.com/watch?v=#{youtube_video_id}"
	end
end
