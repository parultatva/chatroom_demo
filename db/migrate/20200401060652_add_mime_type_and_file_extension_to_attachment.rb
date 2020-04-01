class AddMimeTypeAndFileExtensionToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :mime_type, :string
    add_column :attachments, :file_extension, :string
  end
end
