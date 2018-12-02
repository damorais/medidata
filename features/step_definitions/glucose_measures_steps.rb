Given("I am on Add glucose measure page") do
    visit new_profile_glucose_measure_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the glucose measures page") do
    expect(page).to have_current_path(profile_glucose_measures_path(profile_email: @my_profile.email))
end

Given("I am on glucose measures page") do
    visit profile_glucose_measures_path(profile_email: @my_profile.email)
end

Then("The Add glucose measure page should be displayed") do
    expect(page).to have_current_path(new_profile_glucose_measure_path(profile_email: @my_profile.email))
end

When("I fill the new glucose measure data") do
  fill_in "glucose_measure[value]", with: "1"
  check "glucose_measure[fasting]"
  fill_in "glucose_measure[date]", with: "21/10/2018"
end
