require 'spec_helper'

describe "StaticPages" do

  describe "Static Pages" do
    it "Debe tener la palabra 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end

    it "Deben tener el titulo correcto" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Home")
    end

  end

  describe "Help page" do

    it "Debe tener la palabra 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end

  describe "About page" do

    it "Debe tener la palabra 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
  end


end
