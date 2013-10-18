require "spec_helper"

describe "Proposals" do
	before(:each) do
		user_login
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
		current_path.should eq proposals_path
		page.should_not have_content proposal.reason
	end
end