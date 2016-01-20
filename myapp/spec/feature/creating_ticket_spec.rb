require 'spec_helper'

feature "Creating Tickets" do
    before do
      # FactoryGirl.create(:project, name: "Internet Explorer")
      # visit '/'
      # click_link 'Internet Explorer'
      # click_link 'New Ticket'

      project = FactoryGirl.create(:project)
      user = FactoryGirl.create(:user)
      visit '/'
      click_link project.name
      click_link "New Ticket"
      message = "You need to sign in or sign up before continuing."
      expect(page).to have_content(message)

      fill_in "Name", with: user.name
      fill_in "Password", with: user.password
      click_button "Sign in"

      click_link project.name
      click_link "New Ticket"
    end

    scenario "creating tickets" do
      fill_in "Title", with: "Non-standerd Complience"
      fill_in "Description", with: "Page May be Ugly"
      click_button "Create Ticket"
      expect(page).to have_content("Ticket has been created.")

      within "#ticket #author" do
        expect(page).to have_content("Created by user@email.com")
      end
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
