class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true, index: true # index: true espara hacer éste campo indexado.

      t.timestamps
    end
  end
end
