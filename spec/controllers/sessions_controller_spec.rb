require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

let	(:user) {User.create(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hulu")}

	describe '#create' do
		
		it 'should login the user' do
			session[:user_id] = user.id
			expect(session[:user_id]).to be(user.id)
		end

		it 'should not login if session is not started' do
			expect(session[:user_id]).to be_nil
		end

		it 'should return error if wrong password' do
			post  :create, 
						:user => {"email" => "noemail"}
			expect(JSON.parse(response.body)["error"]).to eq("Invalid username or password")
		end

		it 'should login in the user if valid'do
			post 	:create,
						:user => {"email" => user.email, "password" => user.password}
			expect(JSON.parse(response.body)["user"]).to eq(user.email)
		end

		it 'should destroy the session if the user logs out' do
			post 	:create,
						:user => {"email" => user.email,      				"password" => user.password}
			expect(JSON.parse(response.body)["user"]).to eq(user.email)

			delete :destroy
			expect(session[:user_id]).to be_nil
		end

		it 'should return error if invalid email' do
			post 	:create,
						:user => {"email" => user.email,
											"password" => "WRONG!"}
			expect(JSON.parse(response.body)["error"]).to eq("Invalid username or password")
		end

		it 'backdoor redirects user to the root directory' do
			get :backdoor,
					:user_id => 2
			expect(response.code).to eq('302')
		end
	end
end