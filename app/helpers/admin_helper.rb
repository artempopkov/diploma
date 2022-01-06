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

  def create_new_article
    link_to 'New Article', new_admin_article_path, class: 'btn btn-create' if user_correspondent?
  end

  def destroy_article
    link_to 'Destroy', [:admin, @article], method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-destroy' if user_correspondent_or_admin?
  end

  def send_for_review
    link_to 'Send for review', admin_send_for_review_path(@article), method: :patch, class: 'btn-confirm' if user_correspondent?
  end

  def edit_article
    link_to 'Edit', edit_admin_article_path(@article), class: 'btn btn-edit' if user_correspondent?
  end

  private

  def user_admin?
    current_moderator.admin?
  end

  def user_admin_or_editor?
    current_moderator.admin? || current_moderator.editor?
  end

  def user_correspondent?
    current_moderator.correspondent?
  end

  def user_correspondent_or_admin?
    current_moderator.correspondent? || current_moderator.admin?
  end
end
