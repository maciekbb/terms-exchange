require "spec_helper"

describe "Proposals" do
	before(:each) do
		user_login
	end

	let(:v) { FactoryGirl.create(:user) }
	let(:s) { FactoryGirl.create(:subject) }
	let(:t1) { FactoryGirl.create(:term, subject: s) }
	let(:t2) { FactoryGirl.create(:term, subject: s) }

	it "Can visit proposals site after login in" do
		visit proposals_path
		current_path.should eq proposals_path
	end
	
	it "User should see added proposals" do
		proposal = FactoryGirl.create(:proposal, reason: "Nonono", user: current_user)
		visit proposals_path
		current_path.should eq proposals_path
		page.should have_content proposal.reason
	end

	it "User should not see others' proposals" do
		proposal = FactoryGirl.create(:proposal, reason: "Nonono")
		visit proposals_path
		page.should_not have_content proposal.reason
	end

	it "User see sugested exchanges when available, can accept it, can see when the other side accepts it" do
		p0 = FactoryGirl.create(:proposal, user: current_user, term: t1, preferred: false)
		p1 = FactoryGirl.create(:proposal, user: current_user, term: t2, preferred: true)
		q0 = FactoryGirl.create(:proposal, user: v, term: t2, preferred: false)
		q1 = FactoryGirl.create(:proposal, user: v, term: t1, preferred: true)

		visit proposals_path
		page.should have_content q0.term.to_s

		click_on 'accept'
		p0.reload.accepted.should eq q0
		q0.reload.accepted.should be_nil

		current_path.should eq proposals_path
		page.should have_content "waiting for"


		# simulate the other side acceptance
		q0.accepted = p0
		q0.save!

		visit proposals_path
		current_path.should eq proposals_path
		page.should have_content "exchenaged successfully"
	end

	describe "user can cancell his acceptance as long as the other side doesn't accept" do
		
	end

	it "User can't accept more than one match from certin subject" do
		pending
	end
end