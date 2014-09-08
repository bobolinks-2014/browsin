require 'rails_helper'
 
describe User do
 
  it "fails because no passwrod" do
    user = User.create({email: "rob@rob.com"})
    expect(user.errors[:password].any?).to be_truthy
  end
 
  it "fails because passwrod to short" do
    user = User.create({email: "rob@rob.com", 
      password: 'rob', password_confirmation: 'rob'})
    expect(user.errors[:password].any?).to be_truthy
  end
 
  it "succeeds because password is long enough" do
    user = User.create({:email => "rob@rob.com",
      :password => 'rob123', password_confirmation: 'rob123'})
    expect(user.errors[:password].any?).to be_falsy
  end

 	it "fails because email format is incorrect" do
    user = User.create({:email => "rob.com",
      :password => 'rob123', password_confirmation: "rob123"})
    expect(user.errors[:email].any?).to be_truthy
  end

   it "fails since email is already take" do
    User.create({:email => "rob@rob.com",
      :password => 'rob123', password_confirmation: 'rob123'})
    user = User.create({:email=> "rob@rob.com", :password => "rob123", password_confirmation: 'rob123'})
    expect(user.errors[:email].any?).to be_truthy
  end

  it "shows a user has services tagged" do
    user = User.new({:email => "rob@rob.com",
      :password => 'rob123', :password_confirmation => 'rob123', :service_list => "netflix"})
    expect(user.service_list.to_s).to eq("netflix")
  end

  it "checks if add_service_list adds a service" do
  	Media.create(imdb_id: "123test", service_list: "netflix", platform_list: "movie")
  	user = User.create({:email=> "rob@rob.com", :password => "rob123", password_confirmation: 'rob123'})
  	user.add_service_list({services: ["netflix"]})
  	expect(user.owned_taggings.count).to eq(1)
  end

end