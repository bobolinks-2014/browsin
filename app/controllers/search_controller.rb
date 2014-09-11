class SearchController < ApplicationController
  respond_to :json

  def search
    results = Search.find_results(current_user, params[:query])
    if results[:movies] == []
      render json: {success: false, error: params[:query]}
    else
      render json: {media: results[:movies].collect {|media| SearchResultPresenter.new(media).to_hash}.to_json, matches: results[:matches]}
    end
  end

  def top
    if user_signed_in?
      render json: {media: Search.top_list(current_user).collect {|media| SearchResultPresenter.new(media).to_hash}.to_json, matches: ["top 25 movies based on your available services"]}
    else
      render json: {success: false}
    end
  end

  def filter
    render json: {media: Search.find_media(current_user, params[:lookup]).collect {|media| SearchResultPresenter.new(media).to_hash}.to_json, matches: [params[:lookup]]}
  end
end
