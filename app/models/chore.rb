class Chore < ApplicationRecord
  validates_presence_of :title, presence: true
  validates_presence_of :content, presence: true
end
