Given("I am on Add pressure page") do
    visit new_profile_pressure_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the pressures page") do
    expect(page).to have_current_path(profile_pressures_path(profile_email: @my_profile.email))
end

Given("I am on pressures page") do
    visit profile_pressures_path(profile_email: @my_profile.email)
end

Then("The Add pressure page should be displayed") do
    expect(page).to have_current_path(new_profile_pressure_path(profile_email: @my_profile.email))
end

When("I fill the new pressure data") do
    fill_in "pressure[systolic]", with: "1"
    fill_in "pressure[diastolic]", with: "10"
    select DateTime.now.strftime("%Y"),  from: "pressure_date_1i"
    select DateTime.now.strftime("%B"),  from: "pressure_date_2i"
    select "10",  from: "pressure_date_3i"
    select DateTime.now.strftime("%H"),  from: "pressure_date_4i"
    select DateTime.now.strftime("%M"),  from: "pressure_date_5i"
end
