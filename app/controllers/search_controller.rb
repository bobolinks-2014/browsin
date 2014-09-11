class SearchController < ApplicationController
  respond_to :json

  def search
    find_results
    if @movies == []
      render json: {success: false, error: params[:query]}
    else
      render json: {media:  @movies.to_json(include: :actors, methods: [:genre_icons, :service_icons, :title_rating]), matches: @matches}
    end
  end

  def top
    if user_signed_in?
      render json: {media: top_list.to_json(include: :actors, methods: [:genre_icons, :service_icons]), matches: ["top 25 movies based on your available services"]}
    else
      render json: {success: false}
    end
  end

  def find
    render json: {media: find_media(params[:lookup]).to_json(include: :actors, methods: [:genre_icons, :service_icons, :get_matches, :title_rating]), matches: [params[:lookup]]}
  end

end
