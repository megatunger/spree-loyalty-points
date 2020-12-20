Deface::Override.new(
  virtual_path: 'spree/admin/stores/edit',
  name: 'add_loyalty_points_preferences_to_general_settings_page',
  insert_before: "div.form-buttons",
  text: "
    <div class='row'>
      <fieldset class='loyalty-points no-border-bottom'>
        <legend align='center'><%= I18n.t('spree.loyalty_points_settings')%></legend>
        <% @preferences_loyalty_points.each do |key, value|
            type = SpreeLoyaltyPoints::Config.preference_type(key) %>
            <div class='field'>
              <%= label_tag(key, I18n.t('spree.' + key)) + tag(:br) if type != :boolean %>
              <%= preference_field_tag(key, SpreeLoyaltyPoints::Config[key], type: type) %>
              <p><%= value[0] %></p>
            </div>
        <% end %>
      </fieldset>
    </div>
  "
)
