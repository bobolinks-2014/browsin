require 'rails_helper'
 
describe User do

  describe 'validations' do
    it "should return an error if password is blank" do
      user = User.create({email: "rob@rob.com"})
      expect(user.errors[:password].any?).to be_truthy
    end

    it "should return an error if password is less than 6 chars" do
      user = User.create({email: "rob@rob.com", password: 'rob', password_confirmation: 'rob'})
      expect(user.errors[:password].any?).to be_truthy
    end
   
    it "should not return an error with a password length of 6" do
      user = User.create({email: "rob@rob.com", password: 'rob123', password_confirmation: 'rob123'})
      expect(user.errors[:password].any?).to be_falsy
    end

   	it "should return an error if email is not valid" do
      user = User.create({email: "rob.com", password: 'rob123', password_confirmation: "rob123"})
      expect(user.errors[:email].any?).to be_truthy
    end

    it "should return an error if email is already taken" do
      User.create({email: "rob@rob.com", password: 'rob123', password_confirmation: 'rob123', service_list: "hbo"})
      user = User.create({email: "rob@rob.com", password: "rob123", password_confirmation: 'rob123', service_list: "hbo"})
      expect(user.errors[:email].any?).to be_truthy
    end

    it 'should return an error if service list is missing' do 
      user = User.create({email: "rob@rob.com", password: 'rob123', password_confirmation: 'rob123'})
      expect(user.errors[:service_list].any?).to be_truthy
    end
  end

  describe 'tags' do 
    it "should populate a user's service_list" do
      user = User.new({email: "rob@rob.com", password: 'rob123', password_confirmation: 'rob123', service_list: "netflix"})
      expect(user.service_list.to_s).to eq("netflix")
    end
  end

  describe 'user preferences' do
    let(:user){User.create!({email: "grace@grace.com", password: 'grace123', password_confirmation: 'grace123', service_list: "hbo"})}
    let(:media){Media.create!(service_list: "hbo", imdb_id: "12345", platform_list: "shows")}

    before(:each) do 
      UserPreference.create!(user_id: user.id, imdb_id: media.imdb_id, view_status: "hide")
    end

    it "should increase user's user preferences by 1" do 
      expect(user.user_preferences.count).to eq(1)
    end

    it "should increase user's hidden media by 1" do 
      expect(user.hidden_media.count).to eq(1)
    end
  end
end