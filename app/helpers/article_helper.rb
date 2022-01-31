module ArticleHelper
  def published_time(article)
    return "Not published yet" unless article.published_at

    return "Edit: #{universal_time_format(article.published_at)}" if article.edited?

    universal_time_format(article.published_at)
  end

  def like_heart(article)
    return content_tag(:i, "", class: "icon-heart mr-5") unless current_user

    if current_user.liked?(article)
      link_to "", like_article_path(article, "unlike"), class: "icon-heart-broken mr-5", method: :put, remote: true
    else
      link_to "", like_article_path(article, "like"), class: "icon-heart mr-5", method: :put, remote: true
    end
  end

  def render_article_preview(article, index)
    return render "shared/articles/big_preview_card", article: article if index.zero?

    render "shared/articles/medium_preview_card", article: article
  end

  def comment_form(article)
    return render "comments/form", article: article if current_user

    content_tag(:div, class: "alert alert-danger") do
      link_to "Please login to comment", new_user_session_path
    end
  end

  def universal_time_format(time)
    time.strftime("%d %b %Y, %H:%M")
  end
end
