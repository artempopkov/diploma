class Users::RegistrationsController < Devise::RegistrationsController
  layout :resolve_layout
  before_action :load_models, only: %i[edit update]

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def resolve_layout
    return 'user_profile' if action_name == 'edit' || action_name == 'update'

    'application'
  end

  def load_models
    user_history_service = UserHistoryService.new(@user)
    @likes_amount = user_history_service.likes_amount
    @views_amount = user_history_service.views_amount
    @comments_amount = user_history_service.comments_amount
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end
