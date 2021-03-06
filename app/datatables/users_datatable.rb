class UsersDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_admin_user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      edit: { searchable: false, orderable: false },
      id: { source: 'User.id', cond: :like, searchable: true, orderable: true },
      name: { source: 'User.name', cond: :like, searchable: true, orderable: true },    
      email: { source: 'User.email', cond: :like, searchable: true, orderable: true },  
      destroy: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        edit: link_to('Изменить', edit_admin_user_path(record), class: 'text-decoration-none'),
        id: record.id,
        name: record.name,
        email: record.email,
        destroy: link_to('Удалить', [:admin, record], method: :delete, data: { confirm: "Вы уверены?" }, class: 'text-decoration-none text-right')
      }
    end
  end

  def get_raw_records
    User.all
  end
end
