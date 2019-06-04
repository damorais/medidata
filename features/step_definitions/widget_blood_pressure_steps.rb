Given('I have at least one Blood Pressure registered') do
  @expected_pressure = FactoryBot.create :pressure, :date => Time.now,
                                                    :profile => @my_profile,
                                                    :systolic => 120,
                                                    :diastolic => 80
  @another_pressure = FactoryBot.create :pressure, :date => 1.day.ago,
                                                   :profile => @my_profile,
                                                   :systolic => 180,
                                                   :diastolic => 90

  expect(@my_profile.pressures.size).to be(2)
end

Then('I should see a Blood Pressure widget with the most recent register') do
  widget = find('#widget_latest_pressure')

  expect(widget).to have_content("Systolic: #{@expected_pressure.systolic} mmHg")
  expect(widget).to have_content("Diastolic: #{@expected_pressure.diastolic} mmHg")
  expect(widget).to have_content("Registered: #{@expected_pressure.date.to_date()}")
end
