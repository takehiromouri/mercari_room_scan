class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  
  has_many :labels
end
