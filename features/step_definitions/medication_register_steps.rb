Given("I am on Add medication page") do
    visit new_profile_medication_path(profile_email: @registered_user_email)
end

Then("I should be redirected to the medications page") do
    expect(page).to have_current_path(profile_medications_path(profile_email: @registered_user_email))
end

Given("I am on medications page") do
    visit profile_medications_path(profile_email: @registered_user_email)
end

Then("The Add medication page should be displayed") do
    expect(page).to have_current_path(new_profile_medication_path(profile_email: @registered_user_email))
end

When("I fill the new medication data") do
    fill_in "medication[name]", with: "cataflan"
    fill_in "medication[categorize]", with: "comprimido"
    fill_in "medication[start]", with: "01/10/2018"
    fill_in "medication[finish]", with: "02/10/2018"
    fill_in "medication[dosage]", with: "1 por dia"
    fill_in "medication[infadd]", with: "Dores no ombro"
end
