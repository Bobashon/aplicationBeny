require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App | " }

  describe "Static Pages" do
    it "Debe tener la palabra 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end

    it "Deben tener el titulo 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "#{@base_title}Home")
    end

  end

  describe "Help page" do

    it "Debe tener la palabra 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end

    it "Deben tener el titulo 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "#{@base_title}Help")
    end

  end

  describe "About page" do

    it "Debe tener la palabra 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end

    it "Deben tener el titulo 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "#{@base_title}About Us")
    end
  end

  describe "Contact page" do

    it "Debe tener la palabra 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_content('Contact Us')
    end
    it "Deben tener el titulo 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "#{@base_title}Contact Us")
    end

  end

end
