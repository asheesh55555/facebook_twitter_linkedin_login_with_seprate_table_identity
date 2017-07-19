class Friendship < ApplicationRecord
	belongs_to :bbb, foreign_key: 'sender', class_name: 'User'
  belongs_to :ccc, foreign_key: 'receiver', class_name: 'User'
end
