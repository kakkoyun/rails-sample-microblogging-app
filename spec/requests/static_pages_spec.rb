require 'spec_helper'

describe 'Static Pages' do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe 'Home Page' do
    before {
      visit root_path
    }
    it 'should have the base title' do
      expect(page).to have_title base_title
    end

    it 'should not have custom page title' do
      expect(page).not_to have_title "#{ base_title } | Home"
    end

    it 'should have content "SampleApp"' do
      expect(page).to have_content 'SampleApp'
    end
  end

  describe 'Help Page' do
    it 'should have title "Help"' do
      visit help_path
      expect(page).to have_title "#{ base_title } | Help"
    end

    it 'should have content "Help"' do
      visit help_path
      expect(page).to have_content 'Help'
    end
  end

  describe 'About Page' do
    it 'should have title "About Us"' do
      visit about_path
      expect(page).to have_title "#{ base_title } | About Us"
    end

    it 'should have content "About Us"' do
      visit about_path
      expect(page).to have_content 'About Us'
    end
  end

  describe 'Contact Page' do
    it 'should have title "Contact"' do
      visit contact_path
      expect(page).to have_title "#{ base_title } | Contact"
    end

    it 'should have content "Contact"' do
      visit contact_path
      expect(page).to have_content 'Contact'
    end
  end
end
