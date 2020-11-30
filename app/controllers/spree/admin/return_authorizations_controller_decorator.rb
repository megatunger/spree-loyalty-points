module Spree::Admin::ReturnAuthorizationsControllerDecorator
  Spree::Admin::ReturnAuthorizationsController.class_eval do
    before_action :set_loyalty_points_transactions, only: [:new, :edit, :create, :update]

    private

      def set_loyalty_points_transactions
        @loyalty_points_transactions = @return_authorization.order.loyalty_points_transactions.
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:admin_orders_per_page])
      end
  end
end
