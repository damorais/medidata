Given("I am an registered user with {string} email address") do |email|
    @registered_user_email = email
    #Creates a new profile
    expect(Profile.new(email: @registered_user_email, 
        firstname: "Carlos", 
        lastname: "Constantino", 
        birthdate: "01/07/1967").save).to be(true)
    #Check if the email exists 
    expect(Profile.exists?(email: email)).to be(true)
end

Given("I am on My profile page") do
    visit profile_path(email: @registered_user_email) 
end

Then("I should be redirected to the contacts page") do
    expect(page).to have_current_path(profile_contacts_path(profile_email: @registered_user_email))
end

Given("I am on contacts page") do
    visit profile_contacts_path(profile_email: @registered_user_email)
end

Then("The Add contact page should be displayed") do
    expect(page).to have_current_path(new_profile_contact_path(profile_email: @registered_user_email))
end

Given("I am on Add contact page") do
    visit new_profile_contact_path(profile_email: @registered_user_email)
end

When("I fill the new contact data") do
    fill_in "contact[email]", with: "joaquim@exemplo.org"
    fill_in "contact[name]", with: "Joaquim Torres"
    fill_in "contact[phone]", with: "11988881787"
    fill_in "contact[mobile]", with: "1120939091"	
end

When("I click on {string} button") do |button_label|
    click_on button_label
end