require "rails_helper"

RSpec.feature "Create Person", type: :feature do
  scenario "User creates a person successfully" do
    visit new_person_path

    fill_in "Name", with: "Esteban"
    fill_in "Phone number", with: "1234567890"
    fill_in "Email", with: "esteban@example.com"

    click_button "Create Person"
    expect(page).to have_content("Esteban")
  end

  scenario "User fails to create a person" do
    visit new_person_path

    fill_in "Name", with: ""
    fill_in "Phone number", with: ""
    fill_in "Email", with: ""
    click_button "Create Person"

    expect(page).to have_content("Name can't be blank")
  end
end
