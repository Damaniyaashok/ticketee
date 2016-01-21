require 'spec_helper'

feature 'Creating Projects' do

  before do
    user = FactoryGirl.create(:admin_user)
    puts "===========----"
    puts user.inspect
    puts "===========----"
    sign_in_as!(user)
    visit '/'
    click_link 'New Project'
  end
  scenario "can create project" do

    fill_in 'Name', with: "TextMate 2"
    fill_in 'Description', with: "Editor For The OS X"
    click_button 'Create Project'
    expect(page).to have_content('Project have been created.')

    project = Project.where(name: "TextMate 2").first
    expect(page.current_url).to eql(project_url(project))
    title = "TextMate 2 - Projects - Ticketee"
    expect(page).to have_title(title)
  end

  scenario 'can not create a project' do

    click_button 'Create Project'

    expect(page).to have_content("Project has not been created.")
    expect(page).to have_content("Name can't be blank")
  end

end
