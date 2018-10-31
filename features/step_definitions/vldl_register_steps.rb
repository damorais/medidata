Given("I am on Add VLDL page") do
    visit new_profile_vldl_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the VLDL page") do
    expect(page).to have_current_path(profile_vldls_path(profile_email: @my_profile.email))
end

Given("I am on VLDL page") do
    visit profile_vldls_path(profile_email: @my_profile.email)
end

Then("The Add VLDL page should be displayed") do
    expect(page).to have_current_path(new_profile_vldl_path(profile_email: @my_profile.email))
end

When("I fill the new VLDL data") do
    fill_in "vldl[value]", with: "140"
    fill_in "vldl[date]", with: "21/10/2018"
end
