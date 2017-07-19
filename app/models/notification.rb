class Notification < ApplicationRecord
belongs_to :abc,	foreign_key: 'recipient_id', class_name: 'User'
  belongs_to :xyz, foreign_key: 'actor_id', class_name: 'User'
end
