Given("I am on Add Total page") do
    visit new_profile_total_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the Total page") do
    expect(page).to have_current_path(profile_totals_path(profile_email: @my_profile.email))
end

Given("I am on Total page") do
    visit profile_totals_path(profile_email: @my_profile.email)
end

Then("The Add Total page should be displayed") do
    expect(page).to have_current_path(new_profile_total_path(profile_email: @my_profile.email))
end

When("I fill the new Total data") do
    fill_in "total[value]", with: "140"
    fill_in "total[date]", with: "21/10/2018"
end
