class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email,null:false
      t.string :password_digest ,null:false
    end

    create_table :photos do |t|
      t.belongs_to :user, index: true
      t.string :name_pet     # nombre
      t.string :age          # edad
      t.string :especie      # especie
      t.string :race         # raza
      t.string :photo        # foto 
      t.string :coment       # comentarios
      t.timestamp :created_at # fecha de creacion
    end
  end
end
