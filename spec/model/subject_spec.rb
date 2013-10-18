require "spec_helper"

describe Subject do
	let(:u) { FactoryGirl.create(:user) }
	let(:v) { FactoryGirl.create(:user) }
	let(:s) { FactoryGirl.create(:subject) }
	let(:t1) { FactoryGirl.create(:term, subject: s) }
	let(:t2) { FactoryGirl.create(:term, subject: s) }

	it "match when all conditions are satisfied" do
		p0 = FactoryGirl.create(:proposal, user: u, term: t1, preferred: false)
		p1 = FactoryGirl.create(:proposal, user: u, term: t2, preferred: true)
		q0 = FactoryGirl.create(:proposal, user: v, term: t2, preferred: false)
		q1 = FactoryGirl.create(:proposal, user: v, term: t1, preferred: true)

		s.match(u).should eq [q0]
		s.match(v).should eq [p0]
	end

	it "doesn't match where nothing for exchange from u side" do
		p0 = FactoryGirl.create(:proposal, user: u, term: t1, preferred: false)
		q0 = FactoryGirl.create(:proposal, user: v, term: t2, preferred: false)
		q1 = FactoryGirl.create(:proposal, user: v, term: t1, preferred: true)

		s.match(u).should eq []
		s.match(v).should eq []
	end

	it "doesn't match where nothing for exchange from v side" do
		p0 = FactoryGirl.create(:proposal, user: u, term: t1, preferred: false)
		p1 = FactoryGirl.create(:proposal, user: u, term: t2, preferred: true)
		q0 = FactoryGirl.create(:proposal, user: v, term: t2, preferred: false)

		s.match(u).should eq []
		s.match(v).should eq []
	end

end