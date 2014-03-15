# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create :user }

  before do
    @micropost = user.microposts.build(content: 'Lorem ipsum', user_id: user.id)
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe 'when user id not present' do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
end
