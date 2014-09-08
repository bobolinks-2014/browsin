require 'rails_helper'

RSpec.describe GuideboxParser, :type => :model do
	describe '#parse_json_file' do
		let(:json_file){ "{\"total_results\":57,\"results\":[{\"id\":6959,\"title\":\"Game of Thrones\",\"tvdb\":121361,\"imdb_id\":\"tt0944947\"}]}" }
		
		it 'should accept a JSON object and return an array of hashes' do 
			expect(GuideboxParser.parse_json_file(json_file)[0]).to be_a(Hash)
		end
	end

	describe '#clean_media' do 
		let(:parsed_file){ [{"id"=>6959, "title"=>"Game of Thrones", "tvdb"=>121361, "imdb_id"=>"tt0944947"}] }

		it 'should return an array of three hashes' do 
			expect(GuideboxParser.clean_media(parsed_file, "shows", "hbo")[0].count).to eq(3)
		end

		it 'should return an IMDB id' do 
			expect(GuideboxParser.clean_media(parsed_file, "shows", "hbo")[0]['imdb_id']).to eq("tt0944947")
		end

		it 'should return a service_list' do 
			expect(GuideboxParser.clean_media(parsed_file, "shows", "hbo")[0]['service_list']).to eq("hbo")
		end

		it 'should return a plaform_list' do 
			expect(GuideboxParser.clean_media(parsed_file, "shows", "hbo")[0]['platform_list']).to eq("shows")
		end
	end

	describe '#create_media' do 
		let(:media_data){ [{"imdb_id"=>"tt0944947", "platform_list"=>"shows", "service_list"=>"hbo"}] }

		it 'should return an array of IMDB ids' do 
			expect(GuideboxParser.create_media(media_data)).to be_a(Array)
		end

		it 'should create a Media object' do 
	    expect{GuideboxParser.create_media(media_data)}.to change{Media.count}.from(0).to(1)
		end
	end
end
