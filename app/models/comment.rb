require 'google/api_client'

class Comment < ActiveRecord::Base
	belongs_to :category

	def search_google_api
		client = Google::APIClient.new(
			:application_name => "commentkeeper"
		)
		# youtube	= client.discovered_api('youtube', 'v3')
		binding.pry
	end
end
