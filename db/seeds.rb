# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

videos= ["S3wtN07rtKk", "0z7MaFE-uRQ", "fidq3jow8bc", "Y5II-R_Wl48"]
videos.each do |video|
	vid = Video.from_youtube_video_id(video)
	vid.populate_comments
	# vid.populate_related(4)
end

