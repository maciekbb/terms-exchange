class Proposal < ActiveRecord::Base
  belongs_to :term
  belongs_to :user

  validate :one_proposal_for_term
  validate :one_not_preferred_proposal_for_subject

  def to_s
  	is_preferred = preferred ? "preferred" : "not preferred"
  	"#{term} (#{is_preferred})"
  end

  delegate :subject, to: :term

  def one_proposal_for_term
  	if user.proposals.where(term: term).where.not(id: id).count > 0
  		errors.add(:term, "is already occupied")
  	end
  end

  def one_not_preferred_proposal_for_subject
  	if !preferred and user.proposals.joins(:term).where(preferred: false, terms: { subject_id: subject.id }).where.not(id: id).count > 0
  		errors.add(:term, "for this subject already exists one which is not preferred")
  	end
  end

end
