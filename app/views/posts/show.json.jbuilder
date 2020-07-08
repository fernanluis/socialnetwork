

# una forma
json.post do
  json.id @post.id
  json.body @post.body
  json.user_id @post.user_id
  json.created_at @post.created_at
  json.updated_at @post.updated_at
end

# todo lo que pasamos dentro del bloque se convierte en atributo del obeto json que se esta definiendo.
# es decir posts

# otra forma
json.extract! @post, :id, :body, :user_id, :created_at, :updated_at

# otra forma, la del punto
json.(@post, :id, :body, :user_id, :created_at, :updated_at)
