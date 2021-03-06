class Proposal < ActiveRecord::Base
  belongs_to :term
  belongs_to :user

  validate :one_proposal_for_term
  validate :one_not_preferred_proposal_for_subject
  validate :one_accepted_for_subject

  belongs_to :accepted, foreign_key: 'accepted_id', class_name: 'Proposal'

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

  def one_accepted_for_subject
    if accepted_id and user.proposals.joins(:term).where(terms: { subject_id: subject.id }).where.not(id: id, accepted_id: nil).count > 0
      errors.add(:term, "for this subject one term was already accepted")
    end
  end

  def self.all_matches
    select('a.*').from('proposals AS a').joins('inner join proposals AS b ON a.accepted_id = b.id and b.accepted_id = a.id and a.id > b.id')
  end

end
