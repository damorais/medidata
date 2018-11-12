Then("I should be redirected to the reactions page") do
    expect(page).to have_current_path(profile_reactions_path(profile_email: @my_profile.email))
end

Given("I am on reactions page") do
    visit profile_reactions_path(profile_email: @my_profile.email)
end

Then("The Add Adverse Reaction page should be displayed") do
    expect(page).to have_current_path(new_profile_reaction_path(profile_email: @my_profile.email))
end

Given("I am on Add Adverse Reaction page") do
    visit new_profile_reaction_path(profile_email: @my_profile.email)
end

When("I fill the new reaction data") do
    fill_in "reaction[name]", with: "Propofol"
    fill_in "reaction[cause]", with: "Bradicardias"
    fill_in "reaction[description]", with: "Medicamento"
    fill_in "reaction[start]", with: "21/10/2018"
    fill_in "reaction[finish]", with: "21/10/2018"	
end