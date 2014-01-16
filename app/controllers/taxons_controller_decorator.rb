module Spree
  TaxonsController.class_eval do

    def show
      @taxon = Taxon.find_by_permalink!(params[:id])
      return unless @taxon

      @products = @taxon.products.active

      curr_page = params[:page] || 1
      per_page = 24
      unless Spree::Config.show_products_without_price
        @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
      end
      @products = @products.page(curr_page).per(per_page)
    end

  end
end
