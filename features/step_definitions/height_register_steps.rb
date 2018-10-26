Given("I am on Add height page") do
    visit new_profile_height_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the heights page") do
    expect(page).to have_current_path(profile_heights_path(profile_email: @my_profile.email))
end

Given("I am on heights page") do
    visit profile_heights_path(profile_email: @my_profile.email)
end

Then("The Add height page should be displayed") do
    expect(page).to have_current_path(new_profile_height_path(profile_email: @my_profile.email))
end

When("I fill the new height data") do
    fill_in "height[value]", with: "1.65"
    fill_in "height[date]", with: "21/12/2017"
end