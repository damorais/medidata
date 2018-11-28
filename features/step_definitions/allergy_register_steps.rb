Then("I should be redirected to the allergies page") do
    expect(page).to have_current_path(profile_allergies_path(profile_email: @my_profile.email))
end

Given("I am on allergies page") do
    visit profile_allergies_path(profile_email: @my_profile.email)
end

Then("The Add allergy page should be displayed") do
    expect(page).to have_current_path(new_profile_allergy_path(profile_email: @my_profile.email))
end

Given("I am on Add allergy page") do
    visit new_profile_allergy_path(profile_email: @my_profile.email)
end

When("I fill the new allergy data") do
    fill_in "allergy[name]", with: "Plasil"
    fill_in "allergy[cause]", with: "Medicamento"
    fill_in "allergy[allergen]", with: "Metoclopramida"
    fill_in "allergy[known_reaction]", with: "Sim"		
    fill_in "allergy[description]", with: "Princípio Ativo: Cloridrato de metoclopramida"
	fill_in "allergy[start]", with: "21/10/2018"
    fill_in "allergy[finish]", with: "21/10/2018"	
end