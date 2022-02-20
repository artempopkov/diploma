class CommentsDatatable < ApplicationDatatable
  private

  def data
    comments.map do |comment|
      [].tap do |column|
        column << comment.body

        links = []
        links << link_to("Destroy", [:admin, comment], method: :delete, data: { confirm: "Are you sure?" }, class: 'text-decoration-none')
        column << links.join(" | ")
      end
    end
  end

  def count
    Comment.count
  end

  def total_entries
    comments.count
  end

  def comments
    @comments ||= fetch_comments
  end

  def fetch_comments
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    # will_paginate
    
    comments = Comment.order("#{sort_column} #{sort_direction}")
    comments = comments.page(page).per_page(per_page)
    comments = comments.where(search_string.join(" or "), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(body)
  end
end
