require 'spec_helper'

feature "Creating Tickets" do
    before do
      FactoryGirl.create(:project, name: "Internet Explorer")
      visit '/'
      click_link 'Internet Explorer'
      click_link 'New Ticket'
    end

    scenario "creating tickets" do
      fill_in "Title", with: "Non-standerd Complience"
      fill_in "Description", with: "Page May be Ugly"
      click_button "Create Ticket"
      expect(page).to have_content("Ticket has been created.")
    end

    scenario "creating tickets without valid attributes fails" do
      click_button "Create Ticket"
      expect(page).to have_content("Ticket has not been created.")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Description can't be blank")
    end

    scenario "Description must be more then 10 character" do
      fill_in "Title", with: "Non-standerd complience"
      fill_in "Description", with: "it sucks"
      click_button "Create Ticket"
      expect(page).to have_content("Ticket has not been created.")
      expect(page).to have_content("Description is too short")
    end
end
