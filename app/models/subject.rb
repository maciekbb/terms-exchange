class Subject < ActiveRecord::Base
	has_many :terms

	def to_s
		name
	end

	def match(user)
		matches = []

		u_terms_to_give = user.terms.find_by(subject: self, proposals: { preferred: false }) # p0
		u_terms_to_take = user.terms.where(subject: self, proposals: { preferred: true }) # p1..pn

		if u_terms_to_give and u_terms_to_take.any?
			potential_takers = u_terms_to_give.proposals.where(preferred: true).map { |p| p.user }
			potential_takers.each do |v|
				v_terms_to_give = v.terms.find_by(subject: self, proposals: { preferred: false }) # q0
				if u_terms_to_take.include?(v_terms_to_give)
					matches << v.to_give(self)
				end
			end
		end

		return matches
	end
end
