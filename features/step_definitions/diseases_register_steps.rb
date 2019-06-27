Then("I should be redirected to the diseases page") do
    expect(page).to have_current_path(profile_diseases_path(profile_email: @my_profile.email))
end

Given("I am on diseases page") do
    visit profile_diseases_path(profile_email: @my_profile.email)
end

Then("The Add Disease page should be displayed") do
    expect(page).to have_current_path(new_profile_disease_path(profile_email: @my_profile.email))
end

Given("I am on Add Disease page") do
    visit new_profile_disease_path(profile_email: @my_profile.email)
end

When("I fill the new disease data") do
    fill_in "disease[name]", with: "Cardiovascular"
    fill_in "disease[description]", with: "Arritmias cardíacas"
    fill_in "disease[start]", with: "26/11/2018"
    fill_in "disease[finish]", with: "28/10/2018"	
end
