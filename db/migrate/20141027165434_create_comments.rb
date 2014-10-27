class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    t.string :text
    t.integer :category_id
    end
  end
end
