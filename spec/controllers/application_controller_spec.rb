# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it 'should redirect to profile path after login' do
    @user = FactoryBot.create :user, email: 'joao@example.org'

    target_uri = @controller.after_sign_in_path_for(@user)

    expect(target_uri).to eq(profile_path(email: @user.email))
  end

end
