module SidebarHelper
  def sidebar_posts
    Post.paginated(params[:after])
  end

  def sidebar_link_to(post)
    is_active = current_page? post_path(post)

    %{
<a  href="#{post_path(post)}"
    class="list-group-item list-group-item-action #{'active' if is_active}"
    #{'aria-current="true"' if is_active}
    >
  <p class="mb-1 fw-bold">#{post.title}</p>
  <p class="mb-1"><small>#{l post.created_at, format: '%y-%m-%d'}</small></p>
  <p class="mb-1 fw-bold text-dark"><small>#{post.user.name}</small></p>
</a>
    }.html_safe
  end

  def sidebar_link_to_previous
    %{
<a  href="#"
    class="list-group-item list-group-item-action"
    >
  <p class="mb-1 fw-bold text-center">Previous Page</p>
</a>
    }.html_safe
  end

  def sidebar_link_to_next
    %{
<a  href="#"
    class="list-group-item list-group-item-action"
    >
  <p class="mb-1 fw-bold text-center">Next Page</p>
</a>
    }.html_safe
  end
end
