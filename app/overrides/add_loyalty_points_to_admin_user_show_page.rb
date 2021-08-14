Deface::Override.new(virtual_path: 'spree/admin/users/edit',
  name: 'add_loyalty_points_to_admin_user_show_page',
  insert_after: "[data-hook=admin_user_edit_general_settings]",
  text: "
    <div class='panel panel-default' data-hook='loyalty-points'>
      <div class=panel-heading><%= I18n.t('spree.loyalty_points_balance') %></div>
      <div class=panel-body>
        <% if @user.loyalty_points_balance.present? %>
          <%= link_to number_to_currency(@user.loyalty_points_balance, separator: ',', delimiter: '.'), spree.admin_user_loyalty_points_path(@user) %>
        <% else %>
          <%= I18n.t('spree.no_loyalty_points') %>
        <% end %
      </div>
    </div>
  ")
