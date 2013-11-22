# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


 tenant_nr = 2
 student = 200
 course = 200
 tag_student =  10
 tag_course =  10
 student_entity_type=1
 course_entity_type = 2
 dic=('a'..'z').to_a

# create test data
 mysql_start = Time.now()

print "======================start mysql insert===========================\n"
1.upto(tenant_nr) do |i|
  tags_to_insert=[]

  1.upto(student) do |j|
    0.upto(tag_student) do |l|
      #mysql
     tags_to_insert.push(Tag.new(tenant_id:i.to_s,entity_type_id:student_entity_type.to_s,entity_id:j.to_s,tag:dic[0,dic.length-1].flatten))
    end
  end
  1.upto(course) do |k|
    0.upto(tag_course) do |m|
      tags_to_insert.push(Tag.new(tenant_id:i.to_s,entity_type_id:student_entity_type,entity_id:k.to_s,tag:dic[0,dic.length-1].flatten))
    end
  end
  print "======================begin to import for tenant #{i}===========================\n"
  Tag.import(tags_to_insert)
  print "======================finish tenant #{i}===========================\n"
end


mysql_finish = Time.now

print "======================end mysql insert, consume time #{(mysql_finish-mysql_start)}===========================\n"

print "======================start mongodb insert===========================\n"
mongo_start = Time.now()
1.upto(tenant_nr) do |i|
  tags_to_insert=[]

  1.upto(student) do |j|
    tag_coll=[]
    1.upto(tag_student) do |l|
     tag_coll.push(dic[0,dic.length-1])
    end
    tags_to_insert.push({:tenant_id=>i.to_s,:entity_type_id=>student_entity_type.to_s,:entity_id=>j.to_s,:tags=>tag_coll})
    if ( j>=3 && j.modulo(3)==0)
      TagMongo.collection.insert(tags_to_insert)
      tags_to_insert=[]
    end
  end
  TagMongo.collection.insert(tags_to_insert) if (tags_to_insert.length>0)


  tags_to_insert=[]
  tag_coll_course=[]
  1.upto(course) do |k|
    1.upto(tag_course) do |m|
      tag_coll_course.push(dic[0,dic.length-1].flatten)
    end
    tags_to_insert.push({:tenant_id=>i.to_s,:entity_type_id=>student_entity_type,:entity_id=>k.to_s,:tags=> tag_coll_course})
    if (k>=3 && k.modulo(3)==0  )
      TagMongo.collection.insert(tags_to_insert)
      tags_to_insert=[]
    end
  end

  TagMongo.collection.insert(tags_to_insert) if (tags_to_insert.length>0)

  print "======================finish tenant #{i}===========================\n"
end


mongo_finish = Time.now

print "======================end mongo insert, consume time #{(mongo_finish-mongo_start)}===========================\n"


