class SearchController < ApplicationController
  def index
    @query = params[:q]
    @results = Search.new(@query).results
  end
end
