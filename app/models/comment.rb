require 'google/api_client'
require 'httparty'

class Comment < ActiveRecord::Base

	validates :youtube_comment_id, :presence => true, :uniqueness => true
	validates :video_id, :presence => true
	
	belongs_to :category
	belongs_to :video

end
