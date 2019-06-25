Then("I should be redirected to the relatives historic page") do
    expect(page).to have_current_path(profile_relatives_path(profile_email: @my_profile.email))
end

Given("I am on relatives historic page") do
    visit profile_relatives_path(profile_email: @my_profile.email)
end

Then("The Add Relative page should be displayed") do
    expect(page).to have_current_path(new_profile_relative_path(profile_email: @my_profile.email))
end

Given("I am on Add Relative page") do
    visit new_profile_relative_path(profile_email: @my_profile.email)
end

When("I fill the Relative name and description") do
    fill_in "relative[name]", with: "Joao"
    fill_in "relative[description]", with: "Pressão Alta"
end