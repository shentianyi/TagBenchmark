class AddTenantIdToTag < ActiveRecord::Migration
  def change
    add_column :tags,:tenant_id,:string
    add_index :tags,[:tenant_id,:entity_type_id,:entity_id,:tag]
    add_index :tags, [:tenant_id,:entity_type_id,:entity_id]
    add_index :tags,[:tenant_id,:tag]
  end
end
