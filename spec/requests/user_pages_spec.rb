require 'spec_helper'

describe 'User Pages' do
  subject { page }

  describe 'index page' do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: 'Bob', email: 'bob@example.com')
      FactoryGirl.create(:user, name: 'Ben', email: 'ben@example.com')
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it 'should list each user' do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end

    describe 'pagination' do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

  describe 'Sign Up page' do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { 'Create my Account' }

    describe 'with invalid information' do
      it 'should not create a new user, not change count' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }
        it { should have_title(full_title('Sign Up')) }
        it { should have_content('error') }
      end
    end

    # describe 'with valid information' do
    #   let(:user) { FactoryGirl.create(:user) }
    #   before do
    #     fill_in 'Name', with: user.name
    #     fill_in 'Email', with: user.email
    #     fill_in 'Password', with: user.password
    #     fill_in 'Password Confirmation', with: user.password_confirmation
    #   end
    #   after { user.destroy }

    #   it 'should create a new user' do
    #     expect { click_button(submit) }.to change(User, :count).by(1)
    #   end

    #   describe 'after saving the user' do
    #     before { click_button submit }
    #     let(:user) { User.find_by(email: "foo@bar.com") }

    #     it { should have_link('Sign-out') }
    #     it { should have_title(user.name) }
    #     it { should have_selector('div.alert.alert-success', text: 'Welcome') }
    #   end
    # end
  end

  describe 'User profile page' do
    let(:user) do
      User.create(email: 'q@q.com', name: 'kemal',
                  password: 'aaaaaa', password_confirmation: 'aaaaaa')
    end

    # let(:user) {  FactoryGirl.create(:user) }
    before { visit user_path(user) }
    after { user.destroy }

    it { should have_content user.name }
    it { should have_title user.name }
  end

  describe 'user edit' do
    let(:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    after { user.destroy }

    describe 'page' do
      it { should have_content('Update your profile') }
      it { should have_title('Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe 'with invalid information' do
      before { click_button 'Save changes' }
      it { should have_content('error') }
    end

    describe 'with valid information' do
      let(:new_name)  { 'New Name' }
      let(:new_email) { 'new@example.com' }
      before do
        fill_in 'Name',             with: new_name
        fill_in 'Email',            with: new_email
        fill_in 'Password',         with: user.password
        fill_in 'Confirm Password', with: user.password
        click_button 'Save changes'
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign-out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
