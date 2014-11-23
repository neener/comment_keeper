class AddYoutubeCommentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :youtube_comment_id, :string
  end
end
