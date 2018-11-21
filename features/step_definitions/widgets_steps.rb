# frozen_string_literal: true

Given('I have at least one Weight registered') do
  @expected_weight = FactoryBot.create :weight, date: Time.now, profile: @my_profile, value: 65.0
  @another_weight = FactoryBot.create :weight, date: 1.day.ago, profile: @my_profile, value: 60.0

  expect(@my_profile.weights.size).to be(2)
end

Given("I don't have any weight registered") do
  expect(@my_profile.weights.size).to be(0)
end

Then('I should see a Weight widget with the most recent register') do
  widget = find('#widget_lastest_weight')

  expect(widget).to have_content(@expected_weight.value)
end

Then('I should see a Weight widget warning that {string}') do |message|
  widget = find('#widget_lastest_weight')

  expect(widget).to have_content(message)
end

Given("I don't have any height registered") do
  expect(@my_profile.heights.size).to be(0)
end

Given('I have at least one Height registered') do
  @expected_height = FactoryBot.create :height, date: Time.now, profile: @my_profile, value: 1.80
  @another_height = FactoryBot.create :height, date: 1.day.ago, profile: @my_profile, value: 1.75

  expect(@my_profile.heights.size).to be(2)
end

Then('I should see a Height widget with the most recent register') do
  widget = find('#widget_lastest_height')

  expect(widget).to have_content(@expected_height.value)
end

Then('I should see a Height widget warning that {string}') do |message|
  widget = find('#widget_lastest_height')

  expect(widget).to have_content(message)
end

Given('I have a Weight and a Height registered') do
  @my_weight = FactoryBot.create :weight, date: Time.now, profile: @my_profile, value: 65.0
  @my_height = FactoryBot.create :height, date: Time.now, profile: @my_profile, value: 1.85
  @expected_bmi = 19.0

  expect(@my_profile.weights.size).to be(1)
  expect(@my_profile.heights.size).to be(1)
end

Then('I should see a BMI widget with my BMI') do
  widget = find('#widget_bmi')

  expect(widget).to have_content(@expected_bmi)
end

Then('I should see a BMI widget warning that {string}') do |message|
  widget = find('#widget_bmi')

  expect(widget).to have_content(message)
end

Given('I have at least one Glucose registered') do
  @expected_glucose = FactoryBot.create :glucose_measure, date: Time.now, profile: @my_profile, value: 120
  @another_glucose = FactoryBot.create :glucose_measure, date: 1.day.ago, profile: @my_profile, value: 110

  expect(@my_profile.glucose_measures.size).to be(2)
end

Then('I should see a Glucose widget with the most recent register') do
  widget = find('#widget_lastest_glucose')

  expect(widget).to have_content(@expected_glucose.value)
end

Given("I don't have any glucose registered") do
  expect(@my_profile.glucose_measures.size).to be(0)
end

Then('I should see a Glucose widget warning that {string}') do |message|
  widget = find('#widget_lastest_glucose')

  expect(widget).to have_content(message)
end
