class Album < ApplicationRecord
  validates :year, :band_id, :title, presence: true

  belongs_to :band,
             foreign_key: :band_id,
             class_name: "Band"

  has_many :tracks, dependent: :destroy,
                    foreign_key: :album_id,
                    class_name: "Track"

  def studio?
    self.studio == true ? "Studio" : "Live"
  end

  def attributes_for_show_page
    [self.band.name, self.title, self.year, self.tracks.length]
  end
end
