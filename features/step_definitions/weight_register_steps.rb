# frozen_string_literal: true
Given('I am on My profile page') do
  visit profile_path(email: @my_profile.email)
end

Given('I am on Add weight page') do
  visit new_profile_weight_path(profile_email: @my_profile.email)
end

Then('I should be redirected to the weights page') do
  expect(page).to have_current_path(profile_weights_path(profile_email: @my_profile.email))
end

Given('I am on weights page') do
  visit profile_weights_path(profile_email: @my_profile.email)
end

Then('The Add weight page should be displayed') do
  expect(page).to have_current_path(new_profile_weight_path(profile_email: @my_profile.email))
end

When('I fill the new weight data') do
  fill_in 'weight[value]', with: '67'
  fill_in 'weight[date]', with: '21/12/2017'
end
