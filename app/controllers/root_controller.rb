# exists only to redirect from the root of the application
# to the characters controller while providing the selected
# chronicle
class RootController < ApplicationController
  skip_authorization_check

  # redirect to characters index
  def root
    redirect_to chronicle_characters_path(@selected_chronicle)
  end
end
