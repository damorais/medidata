Given("I have at least one Weight registered") do
    @expected_weight = FactoryBot.create :weight, :date => Time.now, :profile => @my_profile, :value => 65.0 
    @another_weight = FactoryBot.create :weight, :date => 1.day.ago, :profile => @my_profile, :value => 60.0

    expect(@my_profile.weights.size).to be(2)
end

Given("I don't have any weight registered") do
    expect(@my_profile.weights.size).to be(0)
end
  
Then("I should see a Weight widget with the most recent register") do
    widget = find("#widget_lastest_weight")

    expect(widget).to have_content(@expected_weight.value)
end

Then("I should see a Weight widget warning that {string}") do |message|
    widget = find("#widget_lastest_weight")

    expect(widget).to have_content(message)
end

Given("I don't have any height registered") do
    expect(@my_profile.heights.size).to be(0)
end

Given("I have at least one Height registered") do
    @expected_height = FactoryBot.create :height, :date => Time.now, :profile => @my_profile, :value => 1.80
    @another_height = FactoryBot.create :height, :date => 1.day.ago, :profile => @my_profile, :value => 1.75

    expect(@my_profile.heights.size).to be(2)
end
  
Then("I should see a Height widget with the most recent register") do
    widget = find("#widget_lastest_height")

    expect(widget).to have_content(@expected_height.value)
end

Then("I should see a Height widget warning that {string}") do |message|
    widget = find("#widget_lastest_height")

    expect(widget).to have_content(message)
end