class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true

  validates_presence_of :title, :body
  validates_length_of :title, minimum: 3, maximum: 250
  validates_length_of :body, minimum: 3, maximum: 250
end
