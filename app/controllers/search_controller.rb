class SearchController < ApplicationController
  def index
    @query = params[:query]
    @results = Search.new(@query).results
  end
end
