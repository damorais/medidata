Given("I am on Add LDL page") do
    visit new_profile_ldl_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the LDL page") do
    expect(page).to have_current_path(profile_ldls_path(profile_email: @my_profile.email))
end

Given("I am on LDL page") do
    visit profile_ldls_path(profile_email: @my_profile.email)
end

Then("The Add LDL page should be displayed") do
    expect(page).to have_current_path(new_profile_ldl_path(profile_email: @my_profile.email))
end

When("I fill the new LDL data") do
    fill_in "ldl[value]", with: "140"
    fill_in "ldl[date]", with: "21/10/2018"
end
