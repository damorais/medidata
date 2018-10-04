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

Then("I should be redirected to {string} page") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Given("I am on {string} page") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Then("The {string} page should be displayed") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

When("I fill the new weight data") do
    pending # Write code here that turns the phrase above into concrete actions
end

When("I click on {string} button") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see {string} message") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end
  