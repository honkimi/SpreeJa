# static page header insert
Deface::Override.new(
  virtual_path: 'spree/shared/_main_nav_bar',
  name: 'pages_in_header',
  insert_after: '#main-nav-bar > ul:first-child li',
  partial: 'spree/static_content/static_content_header'
)
