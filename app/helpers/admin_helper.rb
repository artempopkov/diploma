module AdminHelper
  def article_creation_time(article)
    if article.updated?
      "edit: #{article.updated_at.strftime('%d %b %Y, %H:%M')}"
    else
      article.created_at.strftime('%d %b %Y, %H:%M')
    end
  end
end
