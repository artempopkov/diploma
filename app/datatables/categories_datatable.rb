class CategoriesDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_admin_category_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      edit: { searchable: false, orderable: false },
      id: { source: 'Category.id' },
      name: { source: 'Category.name', cond: :like, searchable: true, orderable: true },    
      destroy: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        edit: link_to('Изменить', edit_admin_category_path(record), class: 'text-decoration-none'),
        id: record.id,
        name: record.name,
        destroy: link_to('Удалить', [:admin, record], method: :delete, data: { confirm: "Вы уверены?" }, class: 'text-decoration-none text-right')
      }
    end
  end

  def get_raw_records
    Category.all
  end
end
