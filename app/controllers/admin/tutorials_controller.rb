class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(new_tutorial_params)
    if tutorial.save
      if new_tutorial_params[:playlist_id] != nil
          search = YoutubeSearch.new
          video_info = search.playlist_videos(new_tutorial_params[:playlist_id])
          tutorial = Tutorial.find(tutorial.id)
          video_info.each do |video|
          video = tutorial.videos.new(video)
          video.save
          end
          flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it Here', "/tutorials/#{tutorial.id }")}."
          redirect_to admin_dashboard_path
      end
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
    # @tutorial.save
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :playlist_id)
  end
end
