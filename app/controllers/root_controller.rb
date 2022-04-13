class RootController < ApplicationController
  def root
    path = user_signed_in? ? user_root_path : guest_root_path
    redirect_to path
  end
end
