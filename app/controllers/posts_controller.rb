class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :js_request?

  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_post, only: %i[ show edit update remove destroy ]
  before_action :authorize_user!, only: %i[ edit update remove destroy ]

  # GET /posts
  def index
    @page, @pages, @posts = Post.paginated(params[:page])

    render :jumbotron if @posts.none?
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Post was successfully created."
    else
      render :new
    end
  end

  # GET /posts/1
  def show
    before, @comments = @post.comments.before
    @before_comment_id = before&.id
  end

  # GET /posts/1/edit
  def edit
  end

  # PATCH /posts/1
  def update
    if @post.update(post_params)
      flash[:notice] = "Post was successfully updated."
    else
      render :edit
    end
  end

  # GET /posts/1/remove
  def remove
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to root_url, notice: "Post was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def authorize_user!
      return if can_user_edit?

      # the respond_to here is required due to a small bug in Rails
      respond_to do |format|
        # this partial is never used in this application
        format.html { render 'error_403' }
        # this partial is
        format.js   { render 'error_403' }
      end
    end

    # adhoc demonstration 'helper method'
    helper_method def can_user_edit?
      @post.user_id == current_user.id
    end
end
