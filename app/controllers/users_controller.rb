class UsersController < ApplicationController

  # GET /users/:id
  def show
    @user     = User.find(params[:id])
    per_page  = ApplicationRecord::PER_PAGE
    @posts    = @user.posts.reverse_order.limit(per_page)
    @comments = @user.comments.reverse_order.limit(per_page)
  end
end
