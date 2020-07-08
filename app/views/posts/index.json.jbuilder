# A continuación una forma
#json.array!(@posts) do |post|

#  json.extract! post, :id, :body, :user_id

#  json.url posts_url(post, format: json)

#end

# A continuación la otra forma.

json.poblicaciones(@posts) do |post|

  json.extract! post, :id, :body, :user_id

  json.url posts_url(post, format: json)

end
