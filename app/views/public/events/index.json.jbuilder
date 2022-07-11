 #先ほどcontrollerに追加した@eventsから情報を配列化する
 json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.start event.start
  json.end event.end
 end

#json.〇〇は送るデータの型
#event.〇〇はそれに対応するモデルのカラム