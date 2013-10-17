class Term < ActiveRecord::Base
  belongs_to :day
  belongs_to :subject
end
