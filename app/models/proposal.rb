class Proposal < ActiveRecord::Base
  belongs_to :term
  belongs_to :user

  def to_s
  	is_preferred = preferred ? "preferred" : "not preferred"
  	"#{term} is #{is_preferred}"
  end

  def matching
  	Proposal.where(term: term, preferred: !preferred).where.not(user: user)
  end
end
