module AdminHelper
  include ActsAsTaggableOn::TagsHelper

  def admin_published_time_label(article)
    return 'Ещё не опубликованна' unless article.published_at

    published_time_label(article)
  end

  def admin_article_avatar_small_preview(article)
    return article_admin_card_image('no-image.png') unless article.avatar.url

    admin_article_card_image(article.avatar.small_preview.url)
  end

  def admin_article_card_image(image_url)
    image_tag(image_url, class: 'card-img-top img-size', alt: '...')
  end

  def link_to_moderators
    link_to 'Администраторы', admin_moderators_path, class: 'nav-link' if user_admin?
  end

  def link_to_users
    link_to 'Пользователи', admin_users_path, class: 'nav-link' if user_admin?
  end

  def link_to_categories
    link_to 'Категории', admin_categories_path, class: 'nav-link' if user_admin_or_editor?
  end

  def link_to_comments
    link_to 'Комментарии', admin_comments_path, class: 'nav-link' if user_admin?
  end

  def create_new_article
    link_to 'Создать новость', new_admin_article_path, class: 'btn-create' if user_correspondent?
  end

  def destroy_article(article)
    link_to 'Удалить', [:admin, article], method: :delete, data: { confirm: 'Вы уверены?' }, class: 'btn-destroy' if user_correspondent_or_admin? && (article.created? || article.rejected?)
  end

  def edit_article(article)
    link_to 'Изменить', edit_admin_article_path(article), class: 'btn-edit' if user_correspondent?
  end

  def prepare_article(article)
    link_to 'Отправить на проверку',  prepare_admin_article_path(article), method: :patch, data: { confirm: 'Вы уверены?' }, class: 'btn-send_for_review' if user_correspondent? && (article.created? || article.rejected?)
  end

  def publish_article(article)
    link_to 'Опубликовать', publish_admin_article_path(article), method: :patch, data: { confirm: 'Вы уверены?' }, class: 'btn-send_for_review' if user_admin_or_editor? && (article.accepted? || article.archived?) 
  end

  def render_review_form(review, review_statuses)
    render "admin/article_reviews/form", review: review, review_statuses: review_statuses if user_editor?
  end

  def link_to_users_report
    link_to 'Отчёт о пользователях', admin_users_report_path(format: :xlsx), class: 'nav-link' if user_admin?
  end

  def link_to_correspondents_report
    link_to 'Отчёт о корреспондентах', admin_correspondents_report_path(format: :xlsx), class: 'nav-link' if user_admin?
  end

  def link_to_articles_report
    link_to 'Отчёт о статьях', admin_articles_report_path(format: :xlsx), class: 'nav-link' if user_admin?
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
