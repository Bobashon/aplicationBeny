require 'spec_helper'

describe "Autenticacion" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Ingresa') }
    it { should have_selector('title', text: 'Ingresa') }
  end

  describe "Con informacion valida" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Aceptar"
    end

    it { should have_selector('title', text: user.name) }
    it { should have_link('Profile', href: user_path(user)) }
    it { should have_link('Sign out', href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }
  end

  describe "Despues de vivitar otra pagina" do
    before { click_link "Inicio" }
    it { should_not have_selector('div.alert.alert-error') }
  end


end
