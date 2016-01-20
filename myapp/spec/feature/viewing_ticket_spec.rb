
require 'spec_helper'

feature "Viewing Tickets" do
  before do
    textmate_2 = FactoryGirl.create(:project, name: "TextMate 2 ")

    user = FactoryGirl.create(:user)

    ticket = FactoryGirl.create(:ticket,
                project: textmate_2,
                title: "Make it shiny!",
                description: "Gardians , starsbursts! oh My Gooood!")

    ticket.update(user: user)

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")

    FactoryGirl.create(:ticket,
                project: internet_explorer,
                title: "Standerds Complience",
                description: "Isn't a Joke")
    visit '/'

  end

  scenario "viewing tickets for given project" do

    click_link "TextMate 2"


    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standerds Complience")
    click_link "Make it shiny!"

    msg = "You need to sign in or sign up before continuing."
   expect(page).to have_content(msg)

   click_link "Sign in"
   fill_in "Name", with: "username"
   fill_in "Password", with: "password"
   click_button "Sign in"

   click_link "TextMate 2"


    #within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    #end

    expect(page).to_not have_content("Gardians , starsbursts! oh My Gooood!")
  end
end
