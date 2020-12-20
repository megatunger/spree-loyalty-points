# frozen_string_literal: true

require 'spree/core'

module SpreeLoyaltyPoints
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions::Decorators

    isolate_namespace Spree

    engine_name 'spree_loyalty_points'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::LoyaltyPoints
    end

    initializer "spree.loyalty_points_settings", before: :load_config_initializers do
      SpreeLoyaltyPoints::Config = Spree::LoyaltyPointsSettings.new
    end
  end
end
