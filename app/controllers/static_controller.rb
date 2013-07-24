# serve up static content through a controller
# so it can use the rest of the site's layout
class StaticController < ApplicationController
  skip_authorization_check

  # GET index.html
  def index
    @latest_chronicles = Chronicle.order("id DESC").last(10)
  end
end
