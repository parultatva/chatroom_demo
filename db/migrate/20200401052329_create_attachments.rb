class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :message, foreign_key: true
      t.string :avatar

      t.timestamps
    end
  end
end
