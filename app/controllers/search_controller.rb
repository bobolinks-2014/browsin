class SearchController < ApplicationController
  respond_to :json

  def search
    find_results
    if @movies == []
      render json: {success: false, error: params[:query]}
    else
      render json: @movies.to_json(include: :actors, methods: [:genre_icons, :service_icons, :get_matches, :title_rating])
    end
  end

  def top
    if user_signed_in?
      render json: top_list.to_json(include: :actors, methods: [:genre_icons, :service_icons])
    else
      render json: {success: false}
    end
  end

  def find
    render json: find_media(params[:lookup]).to_json(include: :actors, methods: [:genre_icons, :service_icons, :get_matches, :title_rating])
  end

end
