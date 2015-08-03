class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :user
  has_many :albums, dependent: :destroy
  has_many :hidden_items, dependent: :destroy

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end
end
