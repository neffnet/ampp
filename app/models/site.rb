class Site < ActiveRecord::Base
  belongs_to :user
  has_many :albums, dependent: :destroy
  has_many :hidden_items, dependent: :destroy
end
