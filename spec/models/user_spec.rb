require 'spec_helper'

describe User do
  before do
    @user = User.new(email: 'example@example.com', name: 'example',
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to :email }
  it { should respond_to :name }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  it 'should respond to email' do # More explicit
    expect(@user).to respond_to :email
  end

  it { should be_valid }

  # OR

  it "should be valid" do
    expect(@user).to be_valid
  end

  describe 'when name not present' do
    before { @user.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @user.name = 'x' * 51 }
    it { should_not be_valid }
  end

  describe 'when email not present' do
    before { @user.email = '' }
    it { should_not be_valid }
  end

  # Email
  describe 'when email is not properly formatted' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
       foo@bar_baz.com foo@bar+baz.com foo@bar..com]
       addresses.each do |invalid_adress|
        @user.email = invalid_adress
        expect(@user).not_to be_valid
      end
    end
  end

  describe 'when email is properly formatted' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_adress|
        @user.email = valid_adress
        expect(@user).to be_valid
      end
    end
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase # check case sensitivity
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  # Password
  describe "when user's password not present" do
    before do
      @user = User.new(email: 'example@example.com', name: 'example',
                       password: "", password_confirmation: "")
    end
    it { should_not be_valid } # be_invalid
  end

  describe "with a password too short" do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should  be_invalid }
  end

  describe "when user's password mismatched" do
    before { @user.password_confirmation = 'mismatch#asdasdas' }
    it { should_not be_valid }
  end

  describe "return value of authentication" do
    before { @user.save }
    let(:found_user) { User.find_by email: @user.email }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      # Same as 'it'
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
