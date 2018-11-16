# frozen_string_literal: true
Given('I am on the MediData home page') do
  visit '/'
end

Then('I should be redirected to Novo Perfil page') do
  expect(page).to have_current_path(new_profile_path)
end

Given('I am on Novo Perfil page') do
  visit new_profile_path
end

Then('A New Profile with {string} email should be created') do |email|
  expect(Profile.exists?(email: email)).to be(true)
end

Given('An user with {string} email already exists') do |email|
  # Creates a new profile
  expect(Profile.new(email: email,
                     firstname: 'Dummy',
                     lastname: 'Dummy',
                     birthdate: '13/01/1980',
                     sex: 'Male',
                     gender: 'Masculino').save).to be(true)
  # Check if the email exists
  expect(Profile.exists?(email: email)).to be(true)
end

Given('I am an existing User with {string} as my email') do |email|
  # Creates a new profile
  expect(Profile.new(email: email,
                     firstname: 'Joana',
                     lastname: 'da Silva',
                     birthdate: '13/01/1980').save).to be(true)
  # Check if the email exists
  expect(Profile.exists?(email: email)).to be(true)
end

Given('I navigate to Editar Meu Perfil page with {string}') do |profile_email|
  visit edit_profile_path(email: profile_email)
end

Then('I should be redirected to my Profile main page') do
  expect(page).to have_current_path(profile_path(email: 'joao@example.org'))
end

Given('There are another user registered with {string}') do |email|
  FactoryBot.create :user, email: email
  FactoryBot.create :profile, email: email

  expect(User.exists?(email: email)).to be(true)
  expect(Profile.exists?(email: email)).to be(true)
end

Then('I get an error indicating that I can not execute that action') do
  expect(page.status_code).to be(401)
end
