class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :media, :message_id, :mime_type, :file_extension

  def media
  	object.avatar.present? ? (ActionController::Base.asset_host + object.avatar.url).to_s : ""
  end
end
