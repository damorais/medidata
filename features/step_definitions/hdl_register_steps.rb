Given("I am on Add HDL page") do
    visit new_profile_hdl_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the HDL page") do
    expect(page).to have_current_path(profile_hdls_path(profile_email: @my_profile.email))
end

Given("I am on HDL page") do
    visit profile_hdls_path(profile_email: @my_profile.email)
end

Then("The Add HDL page should be displayed") do
    expect(page).to have_current_path(new_profile_hdl_path(profile_email: @my_profile.email))
end

When("I fill the new HDL data") do
    fill_in "hdl[value]", with: "140"
    fill_in "hdl[date]", with: "21/10/2018"
end
