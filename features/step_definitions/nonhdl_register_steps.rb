Given("I am on Add Non-HDL page") do
    visit new_profile_nonhdl_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the Non-HDL page") do
    expect(page).to have_current_path(profile_nonhdls_path(profile_email: @my_profile.email))
end

Given("I am on Non-HDL page") do
    visit profile_nonhdls_path(profile_email: @my_profile.email)
end

Then("The Add Non-HDL page should be displayed") do
    expect(page).to have_current_path(new_profile_nonhdl_path(profile_email: @my_profile.email))
end

When("I fill the new Non-HDL data") do
    fill_in "non_hdl[value]", with: "140"
    fill_in "non_hdl[date]", with: "21/10/2018"
end
