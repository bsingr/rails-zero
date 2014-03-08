class ExamplesController < ApplicationController
  caches_page :cached

  def cached
    render :text => 'cached example'
  end
end
