require 'spec_helper'

describe 'User Pages' do
  subject { page }

  describe 'Sign Up page' do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { "Create my Account" }

    describe 'with invalid information' do
      it 'should not create a new user, not change count' do
        expect(click_button submit).not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in 'Name', with: user.name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Password Confirmation', with: user.password_confirmation
      end

      it 'should create a new user' do
        expect(click_button submit).to change(User, :count).by 1
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'kakkoyun@gmail.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
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
