# frozen_string_literal: true

class ConvertFromRefileToActiveStorage < ActiveRecord::Migration[5.2]
  def up
    create_table :active_storage_blobs do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false

      t.datetime :created_at, null: false

      t.index %i[record_type record_id name blob_id],
              name: 'index_active_storage_attachments_uniqueness',
              unique: true
    end

    Artist.find_each do |artist|
      file = Refile.store.get(episode.image_file_id)

      artist.image_file.attach(io: file, filename: file.name)
    end

    Episode.find_each do |episode|
      file = Refile.store.get(episode.flyer_file_id)

      episode.flyer_file.attach(io: file, filename: file.name)
    end
  end
end
