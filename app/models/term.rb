class Term < ActiveRecord::Base
  belongs_to :day
  belongs_to :subject

  has_many :proposals
  has_many :users, through: :proposals

  def to_s
  	"#{subject}, #{day} at #{hour.strftime("%H:%M")}"
  end

end
