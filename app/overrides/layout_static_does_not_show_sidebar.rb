Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'layout_static_does_not_show_sidebar',
  surround: '.container .row > *:nth-child(2)',
  text: '<% if controller.controller_name != "static_content" %> <%= render_original %> <% end %>'
)
