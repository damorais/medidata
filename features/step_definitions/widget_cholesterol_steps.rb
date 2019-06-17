Given('I have at least one Cholesterol-hdl registered') do
  @expected_hdl = FactoryBot.create :hdl,   date: Time.now,
                                            profile: @my_profile,
                                            value: 13

  @another_hdl = FactoryBot.create :hdl,    date: Time.now,
                                            profile: @my_profile,
                                            value: 20

  expect(@my_profile.hdls.size).to be(2)
end

Then('I should see a Cholesterol-hdl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("HDL: #{@expected_hdl.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_hdl.date.to_date}")
end

Given('I have at least one Cholesterol-ldl registered') do
  @expected_ldl = FactoryBot.create :ldl, date: Time.now,
                                          profile: @my_profile,
                                          value: 13

  @another_ldl = FactoryBot.create :ldl, date: Time.now,
                                         profile: @my_profile,
                                         value: 20

  expect(@my_profile.ldls.size).to be(2)
end

Then('I should see a Cholesterol-ldl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("LDL: #{@expected_ldl.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_ldl.date.to_date}")
end

Given('I have at least one Cholesterol-non-hdl registered') do
  @expected_non_hdl = FactoryBot.create :non_hdl, date: Time.now,
                                                  profile: @my_profile,
                                                  value: 13

  @another_non_hdl = FactoryBot.create :non_hdl, date: Time.now,
                                                 profile: @my_profile,
                                                 value: 20

  expect(@my_profile.non_hdls.size).to be(2)
end

Then('I should see a Cholesterol-non-hdl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("NON-HDL: #{@expected_non_hdl.value} mg/dl")
  expect(widget).to have_content("Registered: #{@another_non_hdl.date.to_date}")
end

Given('I have at least one Cholesterol-vldl registered') do
  @expected_vldl = FactoryBot.create :vldl, date: Time.now,
                                            profile: @my_profile,
                                            value: 15

  @another_vldl = FactoryBot.create :vldl,  date: Time.now,
                                            profile: @my_profile,
                                            value: 15

  expect(@my_profile.vldls.size).to be(2)
end

Then('I should see a Cholesterol-vldl widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("VLDL: #{@expected_vldl.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_vldl.date.to_date}")
end

Given('I have at least one Cholesterol-total registered') do
  @expected_total = FactoryBot.create :total,   date: Time.now,
                                                profile: @my_profile,
                                                value: 15

  @another_total = FactoryBot.create :total,    date: Time.now,
                                                profile: @my_profile,
                                                value: 15

  expect(@my_profile.totals.size).to be(2)
end

Then('I should see a Cholesterol-total widget with the most recent register') do
  widget = find('#widget_latest_cholesterol')

  expect(widget).to have_content("total: #{@expected_total.value} mg/dl")
  expect(widget).to have_content("Registered: #{@expected_total.date.to_date}")
end
