class Term < ActiveRecord::Base
  belongs_to :day
  belongs_to :subject

  def to_s
  	"#{subject}, #{day} at #{hour.strftime("%H:%M")}"
  end
end
