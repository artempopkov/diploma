class ModeratorsDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_admin_moderator_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      edit: { searchable: false, orderable: false },
      id: { source: 'Moderator.id', cond: :like, searchable: true, orderable: true },
      name: { source: 'Moderator.name', cond: :like, searchable: true, orderable: true },    
      email: { source: 'Moderator.email', cond: :like, searchable: true, orderable: true },
      role: { source: 'Moderator.role', searchable: false, orderable: true }, 
      destroy: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        edit: link_to('Edit', edit_admin_moderator_path(record), class: 'text-decoration-none'),
        id: record.id,
        name: record.name,
        email: record.email,
        role: record.role,
        destroy: link_to('Destroy', [:admin, record], method: :delete, data: { confirm: "Are you sure?" }, class: 'text-decoration-none text-right')
      }
    end
  end

  def get_raw_records
    Moderator.all
  end
end
