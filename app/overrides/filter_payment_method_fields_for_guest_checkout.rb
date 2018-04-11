Deface::Override.new(
  virtual_path: 'spree/checkout/_payment',
  name:         'filter_payment_methods_fields_for_guest_checkout',
  replace:      '#payment-method-fields[data-hook]',
  partial:      'spree/checkout/payment/payment_method_fields'
)
