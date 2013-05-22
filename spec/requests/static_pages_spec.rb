require 'spec_helper'

describe "Paginas estaticas" do

  subject { page }

  describe "Pagina inicial" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Bienvenidos') }
    it { should have_selector('title', text: fulltitle('')) }
    it { should_not have_selector 'title', text: '| Inicio' }
  end

  describe "Pagina Ayuda" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Ayuda') }
    it { should have_selector('title', text: fulltitle('Ayuda')) }
  end

  describe "Pagina Nosotros" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'Conocenos') }
    it { should have_selector('title', text: fulltitle('Conocenos')) }
  end

  describe "Pagina Contacto" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contacto') }
    it { should have_selector('title', text: fulltitle('Contacto')) }
  end
end