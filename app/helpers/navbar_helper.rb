module NavbarHelper
  def navbar_links
    if user_signed_in?
      navbar_links_for_user
    else
      navbar_links_for_guest
    end
  end

  def navbar_links_for_guest
    [
      ["Home", posts_path, {}],
      ["Log in", new_user_session_path, {}],
      ["Sign up", new_user_registration_path, {}],
      ["Forgot your password?", new_user_password_path, {}],
    ]
  end

  def navbar_links_for_user
    [
      ["Home", posts_path, {}],
      ["Write", '#', {onclick: "DeviatingInAComprehensibleMaintainableWay.fetch_modal('#{new_post_path(:js)}'); return false;"}],
      ["Account", edit_user_registration_path, {}],
      ["Sign out", destroy_user_session_path, {data: {confirm: 'Are you sure?'}}],
    ]
  end

  def navbar_link_to(title, path, options)
    is_active = current_page? path
    options['class'] = "nav-link #{'active' if is_active}"
    options['aria-current'] = "page" if is_active
    link_to title, path, options
  end
end
