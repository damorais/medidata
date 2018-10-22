Then("I should be redirected to the contacts page") do
    expect(page).to have_current_path(profile_contacts_path(profile_email: @my_profile.email))
end

Given("I am on contacts page") do
    visit profile_contacts_path(profile_email: @my_profile.email)
end

Then("The Add contact page should be displayed") do
    expect(page).to have_current_path(new_profile_contact_path(profile_email: @my_profile.email))
end

Given("I am on Add contact page") do
    visit new_profile_contact_path(profile_email: @my_profile.email)
end

When("I fill the new contact data") do
    fill_in "contact[email]", with: "joaquim@exemplo.org"
    fill_in "contact[name]", with: "Joaquim Torres"
    fill_in "contact[phone]", with: "11988881787"
    fill_in "contact[mobile]", with: "1120939091"	
end
