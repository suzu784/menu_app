 json.array!(@posts) do |post|
  json.id post.id
  json.title post.cook_name
  json.start post.created_at
  json.end post.created_at
 end