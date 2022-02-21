# class CommentsDatatable < ApplicationDatatable
#   private

#   def data
#     comments.map do |comment|
#       [].tap do |column|
#         column << comment.body
#         column << comment.created_at.strftime("%d %b %Y, %H:%M").to_s
#         links = []
#         links << link_to("Destroy", [:admin, comment], method: :delete, data: { confirm: "Are you sure?" }, class: 'text-decoration-none text-right')
#         column << links.join(" | ")
#       end
#     end
#   end

#   def count
#     Comment.count
#   end

#   def total_entries
#     comments.count
#   end

#   def comments
#     @comments ||= fetch_comments
#   end

#   def fetch_comments
#     search_string = []
#     columns.each do |term|
#       search_string << "#{term} like :search"
#     end

#     # will_paginate
    
#     comments = Comment.order("#{sort_column} #{sort_direction}")
#     comments = comments.page(page).per_page(per_page)
#     comments = comments.where(search_string.join(" or "), search: "%#{params[:search][:value]}%")
#   end

#   def columns
#     %w(body)
#   end
# end

# class CommentsDatatable < AjaxDatatablesRails::ActiveRecord
#   def view_columns
#     @view_columns ||= {
#       id: { source: 'Comment.id' },
#       comment: { source: 'Comment.body', cond: :like, searchable: true },
#       date: { source: 'Comment.created_at', searchable: false },
#     }
#   end

#   def data
#     records.map do |record|
#       {
#         id: record.id,
#         comment: record.body,
#         date: record.created_at,
#         DT_RowId: record.id # Unique identifier for each table row will be automatically generated.
#       }
#     end
#   end

#   def get_raw_records
#     Comment.all
#   end
# end


class CommentsDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'Comment.id' },
      comment: { source: 'Comment.body', cond: :like, searchable: true, orderable: true },
      date: { source: 'Comment.created_at', orderable: true },
      options: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        comment: record.body,
        date: record.created_at.strftime("%d %b %Y, %H:%M"),
        options: link_to('Destroy', [:admin, record], method: :delete, data: { confirm: "Are you sure?" }, class: 'text-decoration-none text-right')
      }
    end
  end

  def get_raw_records
    Comment.all
  end
end
