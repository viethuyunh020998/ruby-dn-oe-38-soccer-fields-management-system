module ApplicationHelper
  def full_title page_title
    base_title = t "base.title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  # Authentication admin to perform functions of this admin
  def current_admin?
    current_user.admin?
  end
end
