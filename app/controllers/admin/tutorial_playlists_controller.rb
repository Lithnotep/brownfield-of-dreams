class Admin::TutorialPlaylistsController < Admin::BaseController

  def new
    @tutorial = Tutorial.new  
  end

end
