require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Registrarse') }
    it { should have_selector('title', text: fulltitle('Registrarse')) }
  end

  describe "Pagina de perfil" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end


  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Crear mi cuenta" }

    describe "Informacion invalida" do
      it "no debe crear el usuario" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "mensajes de error" do
        before { click_button submit }

        it { should have_selector('title', text: 'Registrarse') }
        it { should have_content('error') }
      end


    end

    describe "Informacion valida" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmar password", with: "foobar"
      end

      it "Debe crear el usuario" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "Despues de guardar" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
        it { should have_link('Sign out') }
      end

      describe "Saliendo de la aplicacion" do
        before { click_link "Salir" }
        it { should have_link('Ingresar') }
      end



    end

  end
end