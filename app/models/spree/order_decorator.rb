Spree::Order.class_eval do
  include Spree::LoyaltyPoints
  include Spree::Order::LoyaltyPoints

  has_many :loyalty_points_transactions, as: :source
  has_many :loyalty_points_credit_transactions, as: :source
  has_many :loyalty_points_debit_transactions, as: :source

  scope :loyalty_points_not_awarded, -> { includes(:loyalty_points_credit_transactions).where(spree_loyalty_points_transactions: { source_id: nil } ) }

  scope :with_hours_since_payment, ->(num) { where('`spree_orders`.`paid_at` < ? ', num.hours.ago) }

  scope :with_uncredited_loyalty_points, ->(num) { with_hours_since_payment(num).loyalty_points_not_awarded }

  fsm = self.state_machines[:state]
  fsm.after_transition from: fsm.states.map(&:name) - [:complete], to: [:complete], do: :complete_loyalty_points_payments

  # allows to filter out payment methods that don't work for guest checkout,
  # for example loyalty points.
  # The filtering works for payment methods that have guest_checkout: false
  # in their preferences attributes (you need to create them like that)
  def available_payment_methods_for_user(user)
    default_methods = available_payment_methods
    if user.present?
      default_methods
    else
      default_methods.select { |m| m.preferences.fetch(:guest_checkout, true) }
    end
  end
end
