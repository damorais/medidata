Then("I should be redirected to the Health Insurances page") do
  expect(page).to have_current_path(
    profile_health_insurances_path(profile_email: @my_profile.email)
  )
end

Given("I am on Health Insurances page") do
  visit profile_health_insurances_path(profile_email: @my_profile.email)
end

Then("The Add Health Insurance page should be displayed") do
  expect(page).to have_current_path(
    new_profile_health_insurance_path(profile_email: @my_profile.email)
  )
end

Given("I am on New Health Insurance page") do
  visit new_profile_health_insurance_path(profile_email: @my_profile.email) 
end

When("I fill the new health insurance data") do
  fill_in 'health_insurance[name]', with: 'My current and favorite health insurance'
  fill_in 'health_insurance[provider]', with: 'Medidata My Health'
  fill_in 'health_insurance[plan_name]', with: 'Full 200'
  fill_in 'health_insurance[plan_number]', with: '201700123456'
  fill_in 'health_insurance[plan_type]', with: 'Medical'
  fill_in 'health_insurance[start_date]', with: '21/12/2017'
  fill_in 'health_insurance[expiration_date]', with: '21/12/2022'
end
