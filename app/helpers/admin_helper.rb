module AdminHelper
  include ActsAsTaggableOn::TagsHelper

  def link_to_moderators
    link_to 'Moderators', admin_moderators_path, class: 'nav-link' if user_admin?
  end

  def link_to_users
    link_to 'Users', admin_users_path, class: 'nav-link' if user_admin?
  end

  def link_to_categories
    link_to 'Categories', admin_categories_path, class: 'nav-link' if user_admin_or_editor?
  end

  private

  def user_admin?
    current_moderator.admin?
  end

  def user_admin_or_editor?
    current_moderator.admin? || current_moderator.editor?
  end
end
