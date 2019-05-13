class Track < ApplicationRecord
  validates :album_id, :title, :ord, :bonus, presence: true

  belongs_to :album,
             foreign_key: :album_id,
             class_name: "Album"
  has_one :band, through: :album,
                 source: :band

  def bonus_track?
    self.bonus == true ? "Bonus Track" : "Regular Track"
  end
end
