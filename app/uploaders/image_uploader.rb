class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  #def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #  ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  # "default.png"
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #end

  # Process files as they are uploaded:
  #process resize_to_fit: [100, 100]
  #
  # def scale(width, height)
  #   # do something
  # end

  def default_url
    "default.png"

  end

  process :resize_to_limit => [500, 500]
  
  process resize_to_fill: [100, 100, "Center"]

  # Create different versions of your uploaded files:

  version :thumb100 do
    process :resize_to_limit => [100, 100]
  end

  version :thumb70 do
    process :resize_to_limit => [70, 70]
  end

  version :thumb30 do
    process :resize_to_limit => [30, 30]
  end

  version :thumb50 do
    process :resize_to_limit => [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
