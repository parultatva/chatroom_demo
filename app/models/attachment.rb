class Attachment < ApplicationRecord
  belongs_to :message
  mount_uploader :avatar, AvatarUploader
  # mount_base64_uploader :avatar, AvatarUploader
end
