require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  scenario :users
  it "should save a given home path beginning with 'admin' as nil" do
    users(:admin).update_attribute(:home_path, 'admin')
    users(:admin).home_path.should be_nil
  end
end