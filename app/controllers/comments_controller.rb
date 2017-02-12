class CommentsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @comment = @job.comments.new
  end

  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.new(comment_params)

    if @comment.save
      flash[:'success-message'] = "Comment was successfully created!"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
