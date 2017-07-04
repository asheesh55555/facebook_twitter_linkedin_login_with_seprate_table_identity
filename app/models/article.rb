class Article < ApplicationRecord
	 belongs_to :user
	 has_many :endorses
	  acts_as_votable
end
