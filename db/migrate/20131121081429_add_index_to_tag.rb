class AddIndexToTag < ActiveRecord::Migration
  def change
    add_index :tags,[:entity_type_id,:entity_id,:tag]
    add_index :tags,[:entity_type_id,:entity_id]
    add_index :tags,:tag
  end
end
