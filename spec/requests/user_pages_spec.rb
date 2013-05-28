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
        it { should have_link('Salir') }
      end

      describe "Saliendo de la aplicacion" do
        before { click_link "Salir" }
        it { should have_link('Ingresar') }

      
      end
   end


  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end


  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_selector('title', :text=> "Configuracion") }
      it { should have_link('cambiar', href: 'http://gravatar.com/emails') }
    end


    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nombre",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Aceptar"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Salir', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

  end


  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end


end

