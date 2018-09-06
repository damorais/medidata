Given("I am on the MediData home page") do
  visit "/"
end

When("I click on {string}") do |button_label| 
  click_on button_label
end

Then("I should be redirected to Novo Perfil page") do
  expect(page).to have_current_path(new_profile_path)
end

Given("I am on Novo Perfil page") do
  visit new_profile_path
end

When("I fill {string} with {string}") do |field_name, field_value|
  fill_in "profile[#{field_name}]", with: field_value
end

When("I select {string}") do |check_value|
  choose check_value
end

Then("A New Profile with {string} email should be created") do |email|
  expect(Profile.exists?(email: email)).to be(true)
end

Then("A {string} message saying {string} should be exibited") do |css_class_name, content_message|
  expect(page).to have_css(".alert.alert-#{css_class_name}", text: content_message)
end
