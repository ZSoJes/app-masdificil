class Photo < ActiveRecord::Base
  # Remember to create a migration!
attr_accessor :photo
  # El segundo parámetro es el nombre del uploader que se genera el paso 4
  mount_uploader :photo, PhotoUploader
end
