Then("I should be redirected to the allergies page") do
    expect(page).to have_current_path(profile_allergies_path(profile_email: @registered_user_email))
end

Given("I am on allergies page") do
    visit profile_allergies_path(profile_email: @registered_user_email)
end

Then("The Add allergy page should be displayed") do
    expect(page).to have_current_path(new_profile_allergy_path(profile_email: @registered_user_email))
end

Given("I am on Add allergy page") do
    visit new_profile_allergy_path(profile_email: @registered_user_email)
end

When("I fill the new allergy data") do
    fill_in "allergy[name]", with: "Plasil"
    fill_in "allergy[description]", with: "Princípio Ativo: Cloridrato de metoclopramida"
end