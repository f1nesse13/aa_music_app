class Band < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :albums, dependent: :destroy,
                    foreign_key: :band_id,
                    class_name: "Album"

  has_many :tracks, through: :albums,
                    source: :tracks
end
