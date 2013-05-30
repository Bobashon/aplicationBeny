require 'spec_helper'

describe "Paginas estaticas" do

  subject { page }

  it "Deben tener los links correctos" do
    visit root_path
    click_link "Conocenos"
    page.should have_selector 'title', text: fulltitle('Conocenos')
    click_link "Ayuda"
    page.should have_selector 'title', text: fulltitle('Ayuda')
    click_link "Contacto"
    page.should have_selector 'title', text: fulltitle('Contacto')
    click_link "Inicio"
    page.should have_selector 'title', text: fulltitle('')
    click_link "Registrate!"
    page.should have_selector 'title', text: fulltitle('Registrarse')
    click_link "BOB Team"
    page.should have_selector 'title', text: fulltitle('')
  end

  shared_examples_for "staticpages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: fulltitle(page_title)) }
  end

  describe "Pagina inicial" do
    before { visit root_path }

    let(:heading)    { 'Bienvenidos' }
    let(:page_title) { '' }
    it_should_behave_like "staticpages"
    it { should_not have_selector 'title', text: '| Inicio' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Pagina Ayuda" do
    before { visit help_path }

    let(:heading)    { 'Ayuda' }
    let(:page_title) { 'Ayuda' }
    it_should_behave_like "staticpages"
  end

  describe "Pagina Nosotros" do
    before { visit about_path }

    let(:heading)    { 'Conocenos' }
    let(:page_title) { 'Conocenos' }
    it_should_behave_like "staticpages"
  end

  describe "Pagina Contacto" do
    before { visit contact_path }

    let(:heading)    { 'Contacto' }
    let(:page_title) { 'Contacto' }
    it_should_behave_like "staticpages"
  end
  
end