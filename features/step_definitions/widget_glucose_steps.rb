Given('I have at least one Glucose registered') do
  @expected_glucose = FactoryBot.create :glucose_measure, :date => Time.now, 
                                                            :profile => @my_profile,
                                                            :value => 1.5
  @another_glucose = FactoryBot.create :glucose_measure, :date => 1.day.ago,
                                                            :profile => @my_profile,
                                                            :value => 2.0
  expect(@my_profile.glucose_measures.size).to be(2)
end

Then('I should see a Glucose widget with the most recent register') do
  widget = find('#widget_lastest_glucose')
  expect(widget).to have_content("#{@expected_glucose.value} kg")
  expect(widget).to have_content("Registered: #{@expected_glucose.date.to_date()}")
end

Given('I have not added any Glucose measure') do
  expect(@my_profile.glucose_measures.size).to be(0)
end

Then('I should see a Glucose widget the phrase {string}') do |message|
  widget = find('#widget_lastest_glucose')
  expect(widget).to have_content(message)
end
