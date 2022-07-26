 json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.url url_for(new_post_path)
  json.start event.start
  json.end event.end
 end