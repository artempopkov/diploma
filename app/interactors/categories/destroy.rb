module Categories
  class Destroy
    include Interactor

    def call
      Category.transaction do
        EmailSubscription.find_each do |sub|
          sub.subscriptionable_ids.delete(context.category.id)
        end
        context.category.destroy!
      end
    rescue StandardError => exception
      context.fail!(message: 'Ошибка удаления')
    end
  end
end
