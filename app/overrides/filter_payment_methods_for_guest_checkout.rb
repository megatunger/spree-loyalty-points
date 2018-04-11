Deface::Override.new(
  virtual_path: 'spree/checkout/_payment',
  name:         'filter_payment_methods_for_guest_checkout',
  replace:      '#payment-methods[data-hook]',
  partial:      'spree/checkout/payment/payment_methods'
)
