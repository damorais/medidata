Given("I am on Add medical appointment page") do
    visit new_profile_medical_appointment_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the medical appointments page") do
    expect(page).to have_current_path(profile_medical_appointments_path(profile_email: @my_profile.email))
end

Given("I am on medical appointments page") do
    visit profile_medical_appointments_path(profile_email: @my_profile.email)
end

Then("The Add medical appointment page should be displayed") do
    expect(page).to have_current_path(new_profile_medical_appointment_path(profile_email: @my_profile.email))
end

When("I fill the new medical appointment data") do
  fill_in "medical_appointment[specialty]", with: "cardiologist"
  fill_in "medical_appointment[address]", with: "Av. Paulista"
  fill_in "medical_appointment[professional]", with: "Joao"
  select DateTime.now.strftime("%Y"),  from: "medical_appointment_date_1i"
  select DateTime.now.strftime("%m"),  from: "medical_appointment_date_2i"
  select DateTime.now.strftime("%d"),  from: "medical_appointment_date_3i"
  select DateTime.now.strftime("%H"),  from: "medical_appointment_date_4i"
  select DateTime.now.strftime("%M"),  from: "medical_appointment_date_5i"
  fill_in "medical_appointment[note]", with: "phone number: (11) 2222-3333"
end
