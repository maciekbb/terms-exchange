require "spec_helper"

describe Proposal do
	it "only one for certin subject can be 'not preferred'" do
		s = FactoryGirl.create(:subject)
		t1 = FactoryGirl.create(:term, subject: s)
		t2 = FactoryGirl.create(:term, subject: s)
		u = FactoryGirl.create(:user)
		p1 = FactoryGirl.create(:proposal, term: t1, user: u, preferred: false)
		p2 = FactoryGirl.build(:proposal, term: t2, user: u, preferred: false)
		p2.should_not be_valid
	end

	it "only one proposal for certin term" do
		s = FactoryGirl.create(:subject)
		t = FactoryGirl.create(:term, subject: s)
		u = FactoryGirl.create(:user)
		p1 = FactoryGirl.create(:proposal, term: t, user: u, preferred: true)
		p2 = FactoryGirl.build(:proposal, term: t, user: u, preferred: true)
		p2.should_not be_valid
	end
end