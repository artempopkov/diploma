class EmailSubscriptionsController < ApplicationController
  before_action :load_models, only: %i[edit update]
  before_action :load_user, only: %i[index edit update]
  before_action :authenticate_user!

  def index
    @email_subscriptions = @user.email_subscriptions.each_with_object({}) do |sub, hash|
      hash[sub] = sub.subscriptionable_type.constantize.where(id: sub.subscriptionable_ids).map(&:name)
    end
  end

  def edit
    @model = @email_subscription.subscriptionable_type
  end

  def update
    @email_subscription.subscriptionable_ids = @email_subscription.subscriptionable_ids.reject(&:blank?)

    if @email_subscription.update(email_subscription_params)
      redirect_to user_email_subscriptions_path, notice: "Update email subscriptions successfully"
    else
      redirect_to user_email_subscriptions_path, notice: "Update email subscriptions failed"
    end
  end

  private

  def load_models
    @email_subscription = EmailSubscription.find(params[:id])
  end

  def load_user
    @user = current_user
  end

  def email_subscription_params
    params.require(:email_subscription).permit(:user_id, {:subscriptionable_ids => []}, :subscriptionable_type)
  end
end
