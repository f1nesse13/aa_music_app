class Album < ApplicationRecord
  validates :year, :band_id, :title, presence: true

  belongs_to :band,
             foreign_key: :band_id,
             class_name: "Band"

  def studio?
    self.studio == true ? "Studio" : "Live"
  end
end
