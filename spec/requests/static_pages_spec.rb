require 'spec_helper'

describe 'Static Pages' do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }

  describe 'Home Page' do
    before { visit root_path }
    it { should have_title base_title }
    it { should_not have_title "| Home" }
    it { should have_content 'SampleApp' }
  end

  describe 'Help Page' do
    before { visit help_path }
    # See title helper.
    # it { should have_title "#{ base_title } | Help" }
    it { should have_title "#{ base_title } | Help" }
    it { should have_content 'Help' }
  end

  describe 'About Page' do
    before { visit about_path }
    # Another test trick. See spec/support
    it { should have_title(full_title("About Us")) }
    it { should have_content 'About Us' }
  end

  describe 'Contact Page' do
    before { visit contact_path }
    it { should have_title "#{ base_title } | Contact" }
    it { should have_content 'Contact' }
  end
end
