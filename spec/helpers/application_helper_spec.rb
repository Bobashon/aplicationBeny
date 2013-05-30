require 'spec_helper'

describe ApplicationHelper do

  describe "fulltitle" do
    it "should include the page title" do
      fulltitle('AAAA').should =~ /AAAA/
    end

    it "should include the base title" do
      fulltitle('AAAA').should =~ /^Ruby on Rails/
    end

    it "should not include a bar for the home page" do
      fulltitle("").should_not =~ /\|/
    end
  end
end