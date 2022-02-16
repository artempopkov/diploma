module ApplicationHelper
  def flash_type(name)
    return 'success' if name == 'notice'

    'error'
  end
end
