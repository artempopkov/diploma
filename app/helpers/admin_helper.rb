module AdminHelper
  def article_creation_time(article)
    if article.created_at == article.updated_at
      article.created_at.strftime('%d %b %Y, %H:%M')
    else
      "edit: #{article.updated_at.strftime('%d %b %Y, %H:%M')}"
    end
  end
end
