class Subject < ActiveRecord::Base
	has_many :terms

	def to_s
		name
	end

	def match(user)
		matches = []

		u_term_to_give = user.terms.find_by(subject: self, proposals: { preferred: false }) # p0
		u_terms_to_take = user.terms.where(subject: self, proposals: { preferred: true }) # p1..pn
 
		if u_term_to_give and u_terms_to_take.any?
			potential_takers = u_term_to_give.proposals.where(preferred: true).map { |p| p.user }
			potential_takers.each do |v|
				v_terms_to_give = v.terms.find_by(subject: self, proposals: { preferred: false }) # q0
				if u_terms_to_take.include?(v_terms_to_give)
					matches << v.proposals.joins(:term).find_by(terms: { subject_id: self.id }, preferred: false)
				end
			end
		end

		return matches
	end
end
