class Day < ActiveRecord::Base
	has_many :terms

	def to_s
		name
	end
end

