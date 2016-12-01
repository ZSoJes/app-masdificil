class PhotoUploader < CarrierWave::Uploader::Base
  # ...
  include CarrierWave::MiniMagick # You need this to generate different versions of an image
  # include CarrierWave::RMagick
  # include RMagick or MiniMagick support:
  # Que tipo de strorage usará este uploader
  storage :file

  def store_dir
    # Como y donde guardar el archivo ...
    # 'public/upload_directory'
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Versiones del archivo ...
  version :thumb do
    process :resize_to_fill => [280, 280]
  end

  # def filename
  #   "miImagen.#{file.extension}" if original_filename if original_filename
  # end
  
  #Que extensiones vas a aceptar
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
