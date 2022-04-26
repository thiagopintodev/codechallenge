class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :js_request?

  before_action :authenticate_user!, except: %i[ index ]
  before_action :set_post

  # GET /posts/:post_id/comments
  def index
    before, @comments = @post.comments.before(params[:before])
    @before_comment_id = before&.id
  end

  # GET /posts/:post_id/comments/new
  def new
    @comment = @post.comments.build
  end

  # POST /posts/:post_id/comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      #
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:title, :body)
    end
end
