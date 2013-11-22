class TagMongo
  include Mongoid::Document
  field :tenant_id, type: String
  field :entity_type_id, type: String
  field :entity_id,type:String
  field :tags, type: Array
end