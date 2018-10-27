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
  select DateTime.now.strftime("%Y"),  from: "glucose_measure_date_1i"
  select "November",  from: "glucose_measure_date_2i"
  select DateTime.now.strftime("%d"),  from: "glucose_measure_date_3i"
  select DateTime.now.strftime("%H"),  from: "glucose_measure_date_4i"
  select DateTime.now.strftime("%M"),  from: "glucose_measure_date_5i"
end
