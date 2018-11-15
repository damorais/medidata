Given("I am on Add platelet page") do
    visit new_profile_platelet_path(profile_email: @my_profile.email)
end

Then("I should be redirected to the platelets page") do
    expect(page).to have_current_path(profile_platelets_path(profile_email: @my_profile.email))
end

Given("I am on platelets page") do
    visit profile_platelets_path(profile_email: @my_profile.email)
end

Then("The Add platelets page should be displayed") do
    expect(page).to have_current_path(new_profile_platelet_path(profile_email: @my_profile.email))
end

When("I fill the new platelet data") do
  fill_in "platelet[erythrocyte]", with: "1"
  fill_in "platelet[hemoglobin]", with: "2"
  fill_in "platelet[hematocrit]", with: "3"
  fill_in "platelet[vcm]", with: "4"
  fill_in "platelet[hcm]", with: "5"
  fill_in "platelet[chcm]", with: "6"
  fill_in "platelet[rdw]", with: "7"
  fill_in "platelet[leukocytep]", with: "8"
  fill_in "platelet[neutrophilp]", with: "9"
  fill_in "platelet[eosinophilp]", with: "10"
  fill_in "platelet[basophilp]", with: "11"
  fill_in "platelet[lymphocytep]", with: "12"
  fill_in "platelet[monocytep]", with: "13"
  fill_in "platelet[leukocyteul]", with: "14"
  fill_in "platelet[neutrophilul]", with: "15"
  fill_in "platelet[eosinophilul]", with: "16"
  fill_in "platelet[basophilul]", with: "17"
  fill_in "platelet[lymphocyteul]", with: "18"
  fill_in "platelet[monocyteul]", with: "19"
  fill_in "platelet[total]", with: "1000"

end
