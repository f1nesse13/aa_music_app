class Track < ApplicationRecord
  validates :album_id, :title, :ord, presence: true

  belongs_to :album,
             foreign_key: :album_id,
             class_name: "Album"
  has_one :band, through: :album,
                 source: :band
end
