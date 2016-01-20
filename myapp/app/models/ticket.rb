class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  #validates :title, presence: true
  #validates :description, presence: true

  validates :title, :description, presence: true
  validates :description, length: { minimum: 10 }
end
