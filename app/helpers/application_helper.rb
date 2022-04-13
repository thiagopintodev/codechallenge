module ApplicationHelper
  def current_role
     user_signed_in? ? 'user' : 'guest'
  end
end
