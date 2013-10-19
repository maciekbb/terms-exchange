require "spec_helper"

describe Proposal do
	let!(:s) { FactoryGirl.create(:subject) }
	let!(:u) { FactoryGirl.create(:user) }

	it "only one for certin subject can be 'not preferred'" do
		t1 = FactoryGirl.create(:term, subject: s)
		t2 = FactoryGirl.create(:term, subject: s)
		p1 = FactoryGirl.create(:proposal, term: t1, user: u, preferred: false)
		p2 = FactoryGirl.build(:proposal, term: t2, user: u, preferred: false)
		p2.should_not be_valid
	end

	it "only one proposal for certin term" do
		t = FactoryGirl.create(:term, subject: s)
		p1 = FactoryGirl.create(:proposal, term: t, user: u, preferred: true)
		p2 = FactoryGirl.build(:proposal, term: t, user: u, preferred: true)
		p2.should_not be_valid
	end

	it "only one from certin subject can be accepted" do
		t1 = FactoryGirl.create(:term, subject: s)
		t2 = FactoryGirl.create(:term, subject: s)
		p1 = FactoryGirl.create(:proposal, term: t1, user: u, preferred: true, accepted_id: "123")
		p2 = FactoryGirl.build(:proposal, term: t2, user: u, preferred: true, accepted_id: "456")
		p2.should_not be_valid
	end
end