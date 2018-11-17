# frozen_string_literal: true

Given('I am on the main page') do
  visit '/'
end

Then('I should be redirected to the Sign Up page') do
  expect(page).to have_current_path(new_user_registration_path)
end

Then('I should be redirected to the Sign In page') do
  expect(page).to have_current_path(new_user_session_path)
end

Given('I am on the Sign Up page') do
  visit new_user_registration_path
end

When('I fill the new account form') do
  @user = FactoryBot.build :user, email: 'joao@example.org'

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  fill_in 'Password confirmation', with: @user.password
end

Then('My new account should be created') do
  expect(User.exists?(email: @user.email)).to be(true)
end

When('I fill the new account form with an already registered email') do
  @user_already_registered = FactoryBot.create :user, email: 'joana@example.org'
  @user_already_registered.save

  fill_in 'Email', with: @user_already_registered.email
  fill_in 'Password', with: @user_already_registered.password
  fill_in 'Password confirmation', with: @user_already_registered.password
end

Then('I should stay at Sign Up page') do
  expect(page).to have_current_path new_user_registration_path
end

Given('I am on the Sign In page') do
  visit new_user_session_path
end

When('I fill my Email and Password') do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
end

Given('I have an account with {string} email address') do |email|
  @user = FactoryBot.create :user, email: email
  expect(User.exists?(email: email)).to be(true)
end
