Given("I am on the MediData home page") do
  visit "/"
end

When("I click on {string}") do |button_label| 
  click_on button_label
end

Then("I should be redirected to Novo Perfil page") do
  expect(page).to have_current_path(new_profile_path)
end
