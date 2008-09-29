require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::WelcomeController do
  scenario :users
  
  describe "logging in with a home_path user preference" do
    it "should redirect to the user's home_path" do
      users(:admin).update_attribute(:home_path, '/admin/snippets')
      login_as :admin
      get :index
      response.should redirect_to('/admin/snippets')
    end
  end
  
  describe "logging in with no home_path user preference" do
    it "should redirect_to the default path" do
      login_as :admin
      get :index
      response.should redirect_to('/admin/pages')
    end
  end
end