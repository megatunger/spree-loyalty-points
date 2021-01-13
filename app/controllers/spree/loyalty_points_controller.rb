# frozen_string_literal: true

module Spree
  class LoyaltyPointsController < defined?(::Spree::StoreController) ? ::Spree::StoreController : ApplicationController
    def index
      @loyalty_points_transactions = spree_current_user.loyalty_points_transactions.includes(:source).order(updated_at: :desc).
                                     page(params[:page]).
                                     per(params[:per_page] || SpreeLoyaltyPoints::Config[:admin_orders_per_page])
    end
  end
end
