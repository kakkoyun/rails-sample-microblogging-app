require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "Sign Up page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'User profile page' do
    # Amelastion way
    # let(:user) do
    #   User.create(email: 'q@q.com', name: 'kemal',
    #               password: 'aaaaaa', password_confirmation: 'aaaaaa')
    # end

    let(:user) {  FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content user.name }
    it { should have_title user.name }
  end
end
