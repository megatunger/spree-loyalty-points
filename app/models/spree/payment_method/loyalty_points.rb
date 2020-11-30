# frozen_string_literal: true

module Spree
  class PaymentMethod::LoyaltyPoints < PaymentMethod
    def actions
      %w{capture void}
    end

    def can_void?(payment)
      payment.state != 'void'
    end

    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    def capture(_payment, _source, _gateway)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def void(_source, _gateway)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def source_required?
      false
    end

    def cancel(*_args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def credit(_credit_cents, _transaction_id, options = {})
      loyalty_points = options[:originator].reimbursement.return_items.last.return_authorization.loyalty_points
      options[:originator].payment.order.create_credit_transaction(loyalty_points)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end
  end
end
