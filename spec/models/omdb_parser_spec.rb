require 'rails_helper'

RSpec.describe OMDBParser, :type => :model do
	describe '#update_media' do 		
		let(:gb_media){Media.create!(:imdb_id=>"testing123", :service_list=>"hbo", :platform_list=>"shows")}
		let(:imdb_data){[{:imdb_id=>"testing123", :title=>"Game of Thrones", :run_time=>"55 min", :genre_list=>"Adventure, Drama, Fantasy", :actor_list=>"Lena Headey, Peter Dinklage, Emilia Clarke, Maisie Williams", :synopsis=>"Seven noble families fight for control of the mythical land of Westeros.", :rating=>95.0}]}
		let(:netflix_data){[:title=>"Hello World", :imdb_id=>"netflix123", :service_list=>"netflix", :platform_list=>"shows"]}
		let(:netflix_media){Media.create!(:title=>"Hello World", :imdb_id=>"netflix123", :service_list=>"netflix", :platform_list=>"shows")}
		let(:duplicate_data){[:imdb_id=>"testing123", :service_list=>"netflix"]}


		before(:each) do 
			allow(Media).to receive(:find_by_imdb_id){gb_media}
			allow(Media).to receive(:create_media){netflix_media}
		end

		it 'should update media record with IMDB data' do
			expect{OMDBParser.update_media(imdb_data)}.to change{gb_media.run_time}.from(nil).to(55)
		end

		it 'should create new media record for a nonexistent show' do 
			expect{OMDBParser.update_media(netflix_data)}.to change{Media.count}
		end

		it 'should add Netflix to movie that exists' do
			expect {OMDBParser.update_media(duplicate_data)}.to change{gb_media.service_list}
		end
	end
end
