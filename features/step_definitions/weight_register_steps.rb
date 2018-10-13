Given("I am an registered user with {string} email address") do |email|
    @registered_user_email = email
    #Creates a new profile
    expect(Profile.new(email: @registered_user_email, 
        firstname: "João", 
        lastname: "da Silva", 
        birthdate: "13/01/1980").save).to be(true)
    #Check if the email exists 
    expect(Profile.exists?(email: email)).to be(true)
end

Given("I am on My profile page") do
    visit profile_path(email: @registered_user_email) 
end

Given("I am on Add weight page") do
    visit new_profile_weight_path(profile_email: @registered_user_email)
end

Then("I should be redirected to the weights page") do
    expect(page).to have_current_path(profile_weights_path(profile_email: @registered_user_email))
end

Given("I am on weights page") do
    visit profile_weights_path(profile_email: @registered_user_email)
end

Then("The Add weight page should be displayed") do
    expect(page).to have_current_path(new_profile_weight_path(profile_email: @registered_user_email))
end

Then("The {string} page should be displayed") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

When("I fill the new weight data") do
    fill_in "weight[value]", with: "67"
    fill_in "weight[date]", with: "21/12/2017"
end

When("I click on {string} button") do |button_label|
    click_on button_label
end