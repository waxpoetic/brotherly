class Admin::ArtistsController < AdminController
  resource :artist do
    permit :name
  end
end
