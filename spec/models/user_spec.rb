# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do


  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end


  describe "Recordando al usuario" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "Nombre vacio" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "Email vacio" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "Email Invalido" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "Email Valido" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "Email Unico" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "Nombre Unico" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.name = @user.name.upcase
      user_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe "Password Vacio" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "Diferente Passwords y confirmacion" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "Contrasenia Demaciado Corta" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  it { should respond_to(:authenticate) }

  describe "Valor de regreso al autentificarse" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "Password Valido" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "Password Invalido" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "Email con letras Alternat" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "Debe ser guardado con minuscular" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

end
