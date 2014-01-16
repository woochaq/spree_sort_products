module Spree
  module Admin
    TaxonsController.class_eval do
      before_filter :load_taxon, :only => [:sort_products, :update_products]

      def sort_products
        @products = @taxon.products.active
      end

      def update_products
        products = @taxon.classifications
        product_ids_positions = params[:product_positions].split(",").reject(&:blank?).map(&:to_i)
        product_ids_positions.each_with_index do |id, index|
          product = products.detect{|p| p.product_id == id }
          product.update_attributes(:position => index) unless product.nil?
        end
        redirect_to sort_products_taxons_path(@taxonomy.id, @taxon.id), :notice => t(:sort_products_taxons_update_message)
      end

      def load_taxon
        @taxonomy = Taxonomy.find(params[:taxonomy_id])
        @taxon = Taxon.find(params[:id])
      end
    end
  end
end
