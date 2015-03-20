# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Spree::Core::Engine.load_seed if defined?(Spree::Core)

Rails.application.config.active_record.whitelist_attributes = false

Spree::Config[:currency] = "JPY"
 
 
# PaymentMethod
Spree::PaymentMethod::Check.create!(
  {
    name: "チェック",
    description: "チェックによる支払い.",
    active: true
  }
)

 
# OptionType
Spree::OptionType.create!([{
  :name => "Size",
  :presentation => "商品の大きさ",
  :position => 1
  },
  {
    :name => "Color",
    :presentation => "商品の色",
    :position => 2
  }
])

# Option Value
size = Spree::OptionType.find_by_name!("Size")
color = Spree::OptionType.find_by_name!("Color")
Spree::OptionValue.create!([
  {
    :name => "small",
    :presentation => "小",
    :position => 1,
    :option_type => size
  },
  {
    :name => "medium",
    :presentation => "中",
    :position => 2,
    :option_type => size
  },
  {
    :name => "laerge",
    :presentation => "大",
    :position => 3,
    :option_type => size
  },
  {
    :name => "xlarge",
    :presentation => "特大",
    :position => 4,
    :option_type => size
  },
  {
    :name => "red",
    :presentation => "赤",
    :position => 1,
    :option_type => color,
  },
  {
    :name => "green",
    :presentation => "緑",
    :position => 2,
    :option_type => color,
  },
  {
    :name => "blue",
    :presentation => "青",
    :position => 3,
    :option_type => color
  }
])
 
 
# Property
props = [
  {
    :name => "製造元",
    :presentation => "製造元の名称",
  }, 
  {
    :name => "ブランド",
    :presentation => "ブランドの名称",
  }, 
  {
    :name => "素材",
    :presentation => "素材の名称",
  }
]
props.each do |prop|
  Spree::Property.create!(prop)
end
 
# Prototype
prototypes = [
  {
    :name => "シャツ",
    :properties => ["製造元", "ブランド", "素材"]
  }
]

prototypes.each do |prototype_attrs|
  prototype = Spree::Prototype.create!(:name => prototype_attrs[:name])
  prototype_attrs[:properties].each do |property|
    prototype.properties << Spree::Property.where(name: property).first
  end
end
 
# Country
Spree::Country.create!({"name"=>"日本", "iso3"=>"JPN", "iso"=>"JP", "iso_name"=>"JAPAN", "numcode"=>"392"})
 
# Zone
Spree::Zone.create!({:name => "全国共通", :description => "日本全国", :default_tax => true})
Spree::Zone.first.zone_members.create!(:zoneable => Spree::Country.first)
 
# ShippingCategory
Spree::ShippingCategory.destroy_all
Spree::ShippingCategory.create!({:name => "通常梱包"})
 
 
# ShippingMethod
Spree::ShippingMethod.create!({
  :name => "ヤマト宅急便 ",
  :zones => [Spree::Zone.first],
  :shipping_categories => [Spree::ShippingCategory.first],
  :calculator => Spree::Calculator::FlatRate.create!({:preferred_amount => 600, :preferred_currency => "JPY"}),
  :calculator_type => "Spree::Calculator::Shipping::FlatRate"
  })
 
 
# State
country = Spree::Country.first
unless Spree::State.any?
  Spree::State.create!({"name"=>"北海道", "abbr"=>"Hokkaido", :country=>country})
  Spree::State.create!({"name"=>"青森県", "abbr"=>"Aomori", :country=>country})
  Spree::State.create!({"name"=>"岩手県", "abbr"=>"Iwate", :country=>country})
  Spree::State.create!({"name"=>"宮城県", "abbr"=>"Miyagi", :country=>country})
  Spree::State.create!({"name"=>"秋田県", "abbr"=>"Akita", :country=>country})
  Spree::State.create!({"name"=>"山形県", "abbr"=>"Yamagata", :country=>country})
  Spree::State.create!({"name"=>"福島県", "abbr"=>"Fukushima", :country=>country})
  Spree::State.create!({"name"=>"茨城県", "abbr"=>"Ibaraki", :country=>country})
  Spree::State.create!({"name"=>"栃木県", "abbr"=>"Tochigi", :country=>country})
  Spree::State.create!({"name"=>"群馬県", "abbr"=>"Gunma", :country=>country})
  Spree::State.create!({"name"=>"埼玉県", "abbr"=>"Saitama", :country=>country})
  Spree::State.create!({"name"=>"千葉県", "abbr"=>"Chiba", :country=>country})
  Spree::State.create!({"name"=>"東京都", "abbr"=>"Tokyo", :country=>country})
  Spree::State.create!({"name"=>"神奈川県", "abbr"=>"Kanagawa", :country=>country})
  Spree::State.create!({"name"=>"新潟県", "abbr"=>"Niigata", :country=>country})
  Spree::State.create!({"name"=>"富山県", "abbr"=>"Toyama", :country=>country})
  Spree::State.create!({"name"=>"石川県", "abbr"=>"Ishikawa", :country=>country})
  Spree::State.create!({"name"=>"福井県", "abbr"=>"Fukui", :country=>country})
  Spree::State.create!({"name"=>"山梨県", "abbr"=>"Yamanashi", :country=>country})
  Spree::State.create!({"name"=>"長野県", "abbr"=>"Nagano", :country=>country})
  Spree::State.create!({"name"=>"岐阜県", "abbr"=>"Gifu", :country=>country})
  Spree::State.create!({"name"=>"静岡県", "abbr"=>"Shizuoka", :country=>country})
  Spree::State.create!({"name"=>"愛知県", "abbr"=>"Aichi", :country=>country})
  Spree::State.create!({"name"=>"三重県", "abbr"=>"Mie", :country=>country})
  Spree::State.create!({"name"=>"滋賀県", "abbr"=>"Shiga", :country=>country})
  Spree::State.create!({"name"=>"京都府", "abbr"=>"Kyoto", :country=>country})
  Spree::State.create!({"name"=>"大阪府", "abbr"=>"Osaka", :country=>country})
  Spree::State.create!({"name"=>"兵庫県", "abbr"=>"Hyogo", :country=>country})
  Spree::State.create!({"name"=>"奈良県", "abbr"=>"Nara", :country=>country})
  Spree::State.create!({"name"=>"和歌山県", "abbr"=>"Wakayama", :country=>country})
  Spree::State.create!({"name"=>"鳥取県", "abbr"=>"Tottori", :country=>country})
  Spree::State.create!({"name"=>"島根県", "abbr"=>"Shimane", :country=>country})
  Spree::State.create!({"name"=>"岡山県", "abbr"=>"Okayama", :country=>country})
  Spree::State.create!({"name"=>"広島県", "abbr"=>"Hiroshima", :country=>country})
  Spree::State.create!({"name"=>"山口県", "abbr"=>"Yamaguchi", :country=>country})
  Spree::State.create!({"name"=>"徳島県", "abbr"=>"Tokushima", :country=>country})
  Spree::State.create!({"name"=>"香川県", "abbr"=>"Kagawa", :country=>country})
  Spree::State.create!({"name"=>"愛媛県", "abbr"=>"Ehime", :country=>country})
  Spree::State.create!({"name"=>"高知県", "abbr"=>"Kochi", :country=>country})
  Spree::State.create!({"name"=>"福岡県", "abbr"=>"Fukuoka", :country=>country})
  Spree::State.create!({"name"=>"佐賀県", "abbr"=>"Saga", :country=>country})
  Spree::State.create!({"name"=>"長崎県", "abbr"=>"Nagasaki", :country=>country})
  Spree::State.create!({"name"=>"熊本県", "abbr"=>"Kumamoto", :country=>country})
  Spree::State.create!({"name"=>"大分県", "abbr"=>"Oita", :country=>country})
  Spree::State.create!({"name"=>"宮崎県", "abbr"=>"Miyazaki", :country=>country})
  Spree::State.create!({"name"=>"鹿児島県", "abbr"=>"Kagoshima", :country=>country})
  Spree::State.create!({"name"=>"沖縄県", "abbr"=>"Okinawa", :country=>country})
end
 
 
# TaxCategory
Spree::TaxCategory.create!({:name => "消費税一般", :is_default => true})
 
 
# TaxRate
Spree::TaxRate.create!({
  :name => "全国共通",
  :zone => Spree::Zone.first, 
  :amount => 0.08,
  :tax_category => Spree::TaxCategory.first,
  :calculator => Spree::Calculator::DefaultTax.create!
})
 
# Product
Spree::Product.create!({
  :name => "最初の商品",
  :price => 1000,
  :shipping_category => Spree::ShippingCategory.first,
  :tax_category => Spree::TaxCategory.first,
  :description => '商品説明',
  :available_on => Time.zone.now
  })
 
 
# Taxonomy
Spree::Taxonomy.create!([
  {:name => 'ジャンル'}
])

# Taxon 
genre = Spree::Taxonomy.find_by_name!("ジャンル")
taxons = [
  {
    :name => "ジャンル",
    :taxonomy => genre,
    :position => 0
  },
  {
    :name => "ファッション",
    :taxonomy => genre,
    :parent => "ジャンル",
    :position => 1,
    :products => [
      Spree::Product.first
    ]
  },
  {
    :name => "インテリア",
    :taxonomy => genre,
    :parent => "ジャンル",
    :position => 2
  }
]
taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Spree::Taxon.where(name: taxon_attrs[:parent]).first
    Spree::Taxon.create!(taxon_attrs)
  end
end

# StockLocation
Spree::StockLocation.destroy_all
Spree::StockLocation.create!({
  :name => 'デフォルト倉庫',
  :active => true,
  :country => Spree::Country.first
  })
Spree::StockMovement.create!(:quantity => 100, :stock_item => Spree::Variant.first.stock_items.first)

# Refund reason
Spree::RefundReason.destroy_all
Spree::RefundReason.create!(name: "不良品", mutable: false)
Spree::RefundReason.create!(name: "商品が異なる", mutable: false)
 
# Role
Spree::Role.where(:name => "user").first_or_create
Spree::Role.where(:name => "admin").first_or_create
 
# admin
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

