# frozen_string_literal: true

When('I click on {string}') do |button_label|
  click_on button_label
end

When('I fill {string} with {string}') do |field_name, field_value|
  fill_in "profile[#{field_name}]", with: field_value
end

When('I select {string}') do |check_value|
  choose check_value
end

Then('A {string} message saying {string} should be exibited') do |css_class_name, content_message|
  expect(page).to have_css(".alert.alert-#{css_class_name}", text: content_message)
end

Then('An error message saying that {string} should be exibited') do |content_message|
  expect(page).to have_css('div.text-danger.small', text: content_message)
end

When('{string} {string} should be selected') do |radio_name, radio_value|
  expect(page).to have_checked_field(radio_value, name: "profile[#{radio_name.downcase}]")
end

When('The field {string} should have the date {string}') do |field_name, date_value|
  date_as_string = Date.parse(date_value).to_s
  expect(page).to have_field(field_name, with: date_as_string)
end

When('The field {string} should be {string}') do |field_name, field_value|
  expect(page).to have_field(field_name, with: field_value)
end

When('I click on {string} button') do |button_label|
  click_on button_label
end

Given('I am an registered user with {string} email address') do |email|
  @user = FactoryBot.create :user, email: email
  @user.save

  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  # expect(page).to have_current_path(new_profile_path(email: @user.email))
  expect(User.exists?(email: email)).to be(true)
end

Given('I have a registered profile with {string} email address') do |email|
  @my_profile = FactoryBot.create :profile, email: email

  expect(Profile.exists?(email: email)).to be(true)
end
