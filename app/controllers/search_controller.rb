class SearchController < ApplicationController
  respond_to :json

  def search
    results = Search.find_results(current_user, params[:query])
    if results[:movies] == []
      render json: {success: false, error: params[:query]}
    else
      render json: {media: results[:movies].to_json(include: :actors, methods: [:genre_icons, :service_icons, :rating_source]), matches: results[:matches]}
    end
  end

  def top
    if user_signed_in?
      render json: {media: Search.top_list(current_user).to_json(include: :actors, methods: [:genre_icons, :service_icons, :rating_source]), matches: ["top 25 movies based on your available services"]}
    else
      render json: {success: false}
    end
  end

  def filter
    render json: {media: Search.find_media(current_user, params[:lookup]).to_json(include: :actors, methods: [:genre_icons, :service_icons, :rating_source]), matches: [params[:lookup]]}
  end
end
