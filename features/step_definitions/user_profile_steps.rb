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

Given("An user with {string} email already exists") do |email|
  #Creates a new profile
  expect(Profile.new(email: email, 
                     firstname: "Dummy", 
                     lastname: "Dummy", 
                     birthdate: "13/01/1980", 
                     sex: "Male", 
                     gender: "Masculino").save).to be(true)
  #Check if the email exists 
  expect(Profile.exists?(email: email)).to be(true)
end

Then("An error message saying that {string} should be exibited") do |content_message|
  expect(page).to have_css("div.text-danger.small", text: content_message)
end

Given("I am an existing User with {string} as my email") do |email|
  #Creates a new profile
  expect(Profile.new(email: email, 
                     firstname: "Joana", 
                     lastname: "da Silva", 
                     birthdate: "13/01/1980").save).to be(true)
  #Check if the email exists 
  expect(Profile.exists?(email: email)).to be(true)
end

Given("I navigate to Editar Meu Perfil page with {string}") do |profile_email|
  visit edit_profile_path(email: profile_email) 
end

When("The field {string} should be {string}") do |field_name, field_value|
#  expect(page).to have_field("profile[#{field_name}]", with: field_value)
 expect(page).to have_field(field_name, with: field_value)
end

When("The field {string} should have the date {string}") do |field_name, date_value|
  date_as_string = Date.parse(date_value).to_s
  expect(page).to have_field(field_name, with: date_as_string)
end

When("{string} {string} should be selected") do |radio_name, radio_value|
  expect(page).to have_checked_field(radio_value, name: "profile[#{radio_name.downcase}]")
end
