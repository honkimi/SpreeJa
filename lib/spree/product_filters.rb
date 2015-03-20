module Spree
  module Core
    # set up some basic filters for use with products
    #
    # Each filter has two parts
    #  * a parametrized named scope which expects a list of labels
    #  * an object which describes/defines the filter
    #
    # The filter description has three components
    #  * a name, for displaying on pages
    #  * a named scope which will 'execute' the filter
    #  * a mapping of presentation labels to the relevant condition (in the context of the named scope)
    #  * an optional list of labels and values (for use with object selection - see taxons examples below)
    #
    # The named scopes here have a suffix '_any', following Ransack's convention for a
    # scope which returns results which match any of the inputs. This is purely a convention,
    # but might be a useful reminder.
    #
    # When creating a form, the name of the checkbox group for a filter F should be
    # the name of F's scope with [] appended, eg "price_range_any[]", and for
    # each label you should have a checkbox with the label as its value. On submission,
    # Rails will send the action a hash containing (among other things) an array named
    # after the scope whose values are the active labels.
    #
    # Ransack will then convert this array to a call to the named scope with the array
    # contents, and the named scope will build a query with the disjunction of the conditions
    # relating to the labels, all relative to the scope's context.
    #
    # The details of how/when filters are used is a detail for specific models (eg products
    # or taxons), eg see the taxon model/controller.

    # See specific filters below for concrete examples.
    module ProductFilters
      # Example: filtering by price
      #   The named scope just maps incoming labels onto their conditions, and builds the conjunction
      #   'price' is in the base scope's context (ie, "select foo from products where ...") so
      #     we can access the field right away
      #   The filter identifies which scope to use, then sets the conditions for each price range
      #
      # If user checks off three different price ranges then the argument passed to
      # below scope would be something like ["$10 - $15", "$15 - $18", "$18 - $20"]
      #
      Spree::Product.add_search_scope :price_range_any do |*opts|
        conds = opts.map {|o| Spree::Core::ProductFilters.price_filter[:conds][o]}.reject { |c| c.nil? }
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        Spree::Product.joins(master: :default_price).where(scope)
      end

      def ProductFilters.format_price(amount)
        Spree::Money.new(amount)
      end

      def ProductFilters.price_filter
        v = Spree::Price.arel_table
        conds = [ [ Spree.t(:under_price, price: format_price(1000))     , v[:amount].lteq(1000)],
                  [ "#{format_price(1000)} - #{format_price(2000)}"        , v[:amount].in(1000..2000)],
                  [ "#{format_price(2000)} - #{format_price(5000)}"        , v[:amount].in(2000..5000)],
                  [ "#{format_price(5000)} - #{format_price(10000)}"        , v[:amount].in(5000..10000)],
                  [ Spree.t(:or_over_price, price: format_price(10000)) , v[:amount].gteq(10000)]]
        {
          name:   Spree.t(:price_range),
          scope:  :price_range_any,
          conds:  Hash[*conds.flatten],
          labels: conds.map { |k,v| [k, k] }
        }
      end
    end
  end
end

