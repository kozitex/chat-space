json.array! @messages do |message|
  json.id         message.id
  json.user_name  message.user.name
  json.body       message.body
  json.created_at message.created_at.strftime("%Y/%m/%d %H:%M")
  json.image      message.image
end
