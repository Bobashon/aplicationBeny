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
    it { should have_link('Perfil', href: user_path(user)) }
    it { should have_link('Configuracion',    href: edit_user_path(user)) }
    it { should have_link('Salir', href: signout_path) }
    it { should_not have_link('Ingresar', href: signin_path) }
  end

  describe "Despues de visitar otra pagina" do
    before { click_link "Inicio" }
    it { should_not have_selector('div.alert.alert-error') }
  end


  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
  end

end
