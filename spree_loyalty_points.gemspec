# -*- encoding: utf-8 -*-
# stub: spree_loyalty_points 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "spree_loyalty_points".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jatin Baweja".freeze, "Sushant Mittal".freeze]
  s.date = "2020-11-30"
  s.description = "To award loyalty points and add loyalty points payment method to spree".freeze
  s.email = "info@vinsol.com".freeze
  s.files = ["LICENSE".freeze, "README.md".freeze, "app/assets/javascripts".freeze, "app/assets/javascripts/spree".freeze, "app/assets/javascripts/spree/backend".freeze, "app/assets/javascripts/spree/backend/spree_loyalty_points.js".freeze, "app/assets/javascripts/spree/frontend".freeze, "app/assets/javascripts/spree/frontend/spree_loyalty_points.js".freeze, "app/assets/stylesheets/spree".freeze, "app/assets/stylesheets/spree/backend".freeze, "app/assets/stylesheets/spree/backend/spree_loyalty_points.css".freeze, "app/assets/stylesheets/spree/frontend".freeze, "app/assets/stylesheets/spree/frontend/spree_loyalty_points.css".freeze, "app/controllers/spree".freeze, "app/controllers/spree/admin".freeze, "app/controllers/spree/admin/general_settings_controller_decorator.rb".freeze, "app/controllers/spree/admin/loyalty_points_transactions_controller.rb".freeze, "app/controllers/spree/admin/resource_controller_decorator.rb".freeze, "app/controllers/spree/admin/return_authorizations_controller_decorator.rb".freeze, "app/controllers/spree/checkout_controller_decorator.rb".freeze, "app/controllers/spree/loyalty_points_controller.rb".freeze, "app/models/concerns/spree".freeze, "app/models/concerns/spree/loyalty_points.rb".freeze, "app/models/concerns/spree/order".freeze, "app/models/concerns/spree/order/loyalty_points.rb".freeze, "app/models/concerns/spree/payment".freeze, "app/models/concerns/spree/payment/loyalty_points.rb".freeze, "app/models/concerns/spree/transactions_total_validation.rb".freeze, "app/models/spree/app_configuration_decorator.rb".freeze, "app/models/spree/loyalty_points_credit_transaction.rb".freeze, "app/models/spree/loyalty_points_debit_transaction.rb".freeze, "app/models/spree/loyalty_points_transaction.rb".freeze, "app/models/spree/order_decorator.rb".freeze, "app/models/spree/payment_decorator.rb".freeze, "app/models/spree/payment_method".freeze, "app/models/spree/payment_method/loyalty_points.rb".freeze, "app/models/spree/payment_method_decorator.rb".freeze, "app/models/spree/return_authorization_decorator.rb".freeze, "app/models/spree/user_decorator.rb".freeze, "app/overrides/add_condition_to_amount_on_return_authorization_page.rb".freeze, "app/overrides/add_loyalty_points_balance_to_account_page.rb".freeze, "app/overrides/add_loyalty_points_debiting_to_return_authorization_page.rb".freeze, "app/overrides/add_loyalty_points_preferences_to_general_settings_page.rb".freeze, "app/overrides/add_loyalty_points_to_admin_user_show_page.rb".freeze, "app/overrides/add_loyalty_points_to_cart_page.rb".freeze, "app/overrides/add_loyalty_points_to_order_checkout_page.rb".freeze, "app/overrides/add_loyalty_points_to_return_authorization_index_page.rb".freeze, "app/overrides/add_loyalty_points_transaction_table_to_return_authorization_form.rb".freeze, "app/overrides/filter_payment_method_fields_for_guest_checkout.rb".freeze, "app/overrides/filter_payment_methods_for_guest_checkout.rb".freeze, "app/views/spree/admin".freeze, "app/views/spree/admin/loyalty_points_transactions".freeze, "app/views/spree/admin/loyalty_points_transactions/index.html.erb".freeze, "app/views/spree/admin/loyalty_points_transactions/new.html.erb".freeze, "app/views/spree/admin/loyalty_points_transactions/order_transactions.rabl".freeze, "app/views/spree/admin/payments".freeze, "app/views/spree/admin/payments/source_forms".freeze, "app/views/spree/admin/payments/source_forms/_loyaltypoints.html.erb".freeze, "app/views/spree/admin/payments/source_views".freeze, "app/views/spree/admin/payments/source_views/_loyaltypoints.html.erb".freeze, "app/views/spree/checkout".freeze, "app/views/spree/checkout/payment".freeze, "app/views/spree/checkout/payment/_loyaltypoints.html.erb".freeze, "app/views/spree/checkout/payment/_payment_method_fields.html.erb".freeze, "app/views/spree/checkout/payment/_payment_methods.html.erb".freeze, "app/views/spree/loyalty_points".freeze, "app/views/spree/loyalty_points/_transaction_table.html.erb".freeze, "app/views/spree/loyalty_points/index.html.erb".freeze, "config/locales/en.yml".freeze, "config/routes.rb".freeze, "db/migrate/20140116090042_add_loyalty_points_balance_to_spree_user.rb".freeze, "db/migrate/20140116110437_create_loyalty_points_transactions.rb".freeze, "db/migrate/20140117062720_add_timestamps_to_loyalty_points_transaction.rb".freeze, "db/migrate/20140117065314_add_fields_to_spree_loyalty_points_transaction.rb".freeze, "db/migrate/20140122084005_add_comment_to_spree_loyalty_points_transaction.rb".freeze, "db/migrate/20140123092709_add_paid_at_to_spree_order.rb".freeze, "db/migrate/20140123120355_add_loyalty_points_to_spree_return_authorization.rb".freeze, "db/migrate/20140124121728_add_loyalty_points_awarded_to_spree_order.rb".freeze, "db/migrate/20140130131957_rename_fields_in_spree_loyalty_points_transaction.rb".freeze, "db/migrate/20140131072702_remove_loyalty_points_awarded_from_spree_order.rb".freeze, "db/migrate/20140203063433_add_indexing_to_spree_loyalty_points_transaction.rb".freeze, "db/migrate/20140205111553_add_transaction_id_to_spree_loyalty_points_transactions.rb".freeze, "db/migrate/20140207055836_add_lock_version_to_spree_user.rb".freeze, "lib/generators".freeze, "lib/generators/spree_loyalty_points".freeze, "lib/generators/spree_loyalty_points/install".freeze, "lib/generators/spree_loyalty_points/install/install_generator.rb".freeze, "lib/spree_loyalty_points".freeze, "lib/spree_loyalty_points.rb".freeze, "lib/spree_loyalty_points/engine.rb".freeze, "lib/spree_loyalty_points/factories.rb".freeze, "lib/tasks/loyalty_points".freeze, "lib/tasks/loyalty_points/award.rake".freeze]
  s.homepage = "http://vinsol.com".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.requirements = ["none".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Add loyalty points to spree".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<solidus>.freeze, [">= 0"])
    s.add_development_dependency(%q<capybara>.freeze, ["~> 2.5"])
    s.add_development_dependency(%q<coffee-rails>.freeze, ["~> 4.2.1"])
    s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.5.3"])
    s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4.5"])
    s.add_development_dependency(%q<ffaker>.freeze, ["~> 2.2.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.4"])
    s.add_development_dependency(%q<rspec-activemodel-mocks>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda-matchers>.freeze, ["~> 3.1.1"])
    s.add_development_dependency(%q<sass-rails>.freeze, ["~> 5.0.0"])
    s.add_development_dependency(%q<selenium-webdriver>.freeze, ["~> 3.0.8"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.13.0"])
    s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3.13"])
  else
    s.add_dependency(%q<solidus>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, ["~> 2.5"])
    s.add_dependency(%q<coffee-rails>.freeze, ["~> 4.2.1"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.5.3"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 4.5"])
    s.add_dependency(%q<ffaker>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rspec-activemodel-mocks>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, ["~> 3.1.1"])
    s.add_dependency(%q<sass-rails>.freeze, ["~> 5.0.0"])
    s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.0.8"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.13.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3.13"])
  end
end
