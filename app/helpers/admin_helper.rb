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
    link_to 'New Article', new_admin_article_path, class: 'btn-create' if user_correspondent?
  end

  def destroy_article(article)
    link_to 'Destroy', [:admin, article], method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn-destroy' if user_correspondent_or_admin?
  end

  def edit_article(article)
    link_to 'Edit', edit_admin_article_path(article), class: 'btn-edit' if user_correspondent?
  end

  def prepare_article(article)
    link_to 'Send for review',  prepare_admin_article_path(article), method: :patch, data: { confirm: 'Are you sure?' }, class: 'btn-send_for_review' if user_correspondent? && (article.created? || article.rejected?)
  end

  def publish_article(article)
    link_to 'Publish', publish_admin_article_path(article), method: :patch, data: { confirm: 'Are you sure?' }, class: 'btn-send_for_review' if user_admin_or_editor? && (article.accepted? || article.archived?) 
  end

  def render_review_form(review, review_statuses)
    render "admin/article_reviews/form", review: review, review_statuses: review_statuses if user_editor?
  end

  private

  def user_admin?
    current_moderator.admin?
  end

  def user_editor?
    current_moderator.editor?
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
