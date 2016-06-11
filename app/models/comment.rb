class Comment < ActiveRecord::Base
  belongs_to :post

  validates :name, presence: true, length: { minimum: 3, maximum: 60 }
  validates :body, presence: true, length: { minimum: 3, maximum: 140 }

  scope :latest, ->{ order('created_at DESC') }
end
