## Spree for Japanese
Japanese-localized Spree template.

## Installation

```
git clone this
cd spreeja
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
```

## How to update

#### Assets (Image, CSS, JavaScript)

`vendor/assets/`を修正 

#### View (Only HTML)
##### HTMLで全部上書き

Spree の本家コードから修正したいviewの場所を特定。

例えば`frontend/app/views/spree/shared/_header.html.erb` を編集したい場合、`app/views/spree/shared/_header.html.erb`を作成し、編集する。

ただし、このやり方は Spree を常に最新にする場合に古いままのHTMLが使われ続けた状態になってしまうのが問題。

##### Deface で追加

`app/overrides` 以下に Ruby ファイルを追加。こんな感じで書ける

`replace_header_logo.rb`

```
Deface::Override.new(:virtual_path => 'spree/shared/_header',
  :name => 'replace_header_logo',
  :replace_contents => "#logo",   
  :text => "
    <%= image_path 'logo.png', :alt => 'Logo' %>
  ")
```

### Controller
`class_eval`でデコレートすることで既存コントローラに追加する。

`app/controllers/spree/home_controller_decorator.rb`を作成

```
module Spree
  HomeController.class_eval do
    respond_override :index => { :html =>
      { :success => lambda { render 'shared/some_file' } } }

    def sale
      @products = Product.joins(:variants_including_master).where('spree_variants.sale_price is not null').uniq
    end
  end
end
```

`respond_override` は既存のアクションの表示を変えたい時に利用。 `sale` は新規ページ。config/routes にルーティング設定が必要

### Model
Migration が必要なレベルの開発は、 [Spree エクステンションとして開発](http://dev.yukashikado.co.jp/post/55659922874/spree-2-2)すべき。

既存のモデル機能拡張には Decorator を用いる。

`Papp/models/spree/product_decorator.rb`

```
module Spree
  Product.class_eval do
    alias_method :orig_price_in, :price_in
    def price_in(currency)
      return orig_price_in(currency) unless sale_price.present?
      Spree::Price.new(:variant_id => self.id, :amount => self.sale_price, :currency => currency)
    end
  end
end
```

メソッドを別名定義しつつ、機能拡張したメソッドで定義元メソッドを呼び出す。

## 特集ページ
admin設定の特集ページより

- `STORES`の項目のみチェック
- header へ表示も使える

## AWS(S3)

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_S3_BUCKET=
```

## Email
設定のメール設定.Gmail で送ってみたい場合

- smtp.gmail.com
- smtp.gmail.com
- 587
- TLS
- plain
- gmail address
- gmail password

## TODO

- Deploy issue (Heroku & SSL)
- 特商法関連の精査

## Memo
[Spree Contrib](https://github.com/spree-contrib) で 3-0-stable ブランチが出るの待ち

- [spree_comments](https://github.com/spree-contrib/spree_comments)
- [spree_editor](https://github.com/spree-contrib/spree_editor)
- [spree_sitemap](https://github.com/spree-contrib/spree_sitemap)
- [spree_social_products](https://github.com/spree-contrib/spree_social_products)
- [spree_recently_viewed](https://github.com/spree-contrib/spree_recently_viewed)
- [spree_reviews](https://github.com/spree-contrib/spree_reviews)
- [spree_related_products](https://github.com/spree-contrib/spree_related_products)

