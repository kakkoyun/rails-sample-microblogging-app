require 'spec_helper'

describe 'Static Pages' do

  describe 'Home Page' do
    it 'should have content "SampleApp"' do
      visit '/static_pages/home'
      expect(page).to have_content 'SampleApp'
    end
  end

  describe 'Help Page' do
    it 'should have content "Help"' do
      visit '/static_pages/help'
      expect(page).to have_content 'Help'
    end
  end

  describe 'About Page' do
    it 'should have content "About Us"' do
      visit '/static_pages/about'
      expect(page).to have_content 'About Us'
    end
  end

end
