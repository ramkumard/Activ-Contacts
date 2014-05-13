class AddAttachmentDocumentToContactImports < ActiveRecord::Migration
  def self.up
    change_table :contact_imports do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :contact_imports, :document
  end
end
