class EmailSubscriptionsController < ApplicationController
  before_action :load_models, only: %i[new edit create update]
  before_action :load_user, only: %i[index new edit create update]
  # before_action :authenticate_user!, only: %i[sho]

  def index
    @email_subscriptions = @user.email_subscriptions.each_with_object({}) do |sub, hash|
      hash[sub] = sub.subscriptionable_type.constantize.where(id: sub.subscriptionable_ids).map(&:name)
    end
  end

  def new
    @email_subscription = @user.email_subscriptions.build()
  end

  def edit
    # authorize @user
    @model = @email_subscription.subscriptionable_type
  end

  def create
    @email_subscription = @user.email_subscriptions.new(email_subscription_params)
    @email_subscription.subscriptionable_ids = @email_subscription.subscriptionable_ids.reject(&:blank?)
   
    if @email_subscription.save
      logger.debug "Sub #{email_subscription_params.inspect}"
    else
      logger.debug "Sub #{@email_subscription.errors.full_messages}"
      redirect_to root_path, alert: "aa -- #{@email_subscription.inspect}"
    end
  end

  def update
    # authorize @user
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
