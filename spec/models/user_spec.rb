require 'spec_helper'

describe User do
  before { @user = User.new email: 'example@example.com', name: 'example' }
  subject { @user }

  it { should respond_to :email }
  it { should respond_to :name }

  it 'should respond to email' do # More explicit
    expect(@user).to respond_to :email
  end

end
