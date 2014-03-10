class ExamplesController < ApplicationController
  caches_page :cached

  def cached
    respond_to do |format|
      format.html
      format.json { render :json => ['cached example'] }
    end
  end
end
