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
        options: link_to('Destroy', [:admin, record], method: :delete, data: { confirm: "Вы уверены?" }, class: 'text-decoration-none text-right')
      }
    end
  end

  def get_raw_records
    Comment.all
  end
end
