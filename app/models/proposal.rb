class Proposal < ActiveRecord::Base
  belongs_to :term
  belongs_to :user

  def to_s
  	is_preferred = preferred ? "preferred" : "not preferred"
  	"#{term} (#{is_preferred})"
  end

end
