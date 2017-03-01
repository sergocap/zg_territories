module Searchers
  class Searcher
    attr_accessor :search_params

    def initialize(args = {})
      @search_params = Hashie::Mash.new args
    end
  end

  class OrganizationSearcher < Searcher
    def search
      search_params.list_items.reject!(&:empty?) if search_params.list_items
      search_params.hierarch_list_items.reject!(&:empty?) if search_params.hierarch_list_items
      search = Value.search do
        fulltext search_params.text if search_params.text

        with :category_id, search_params.category_id if search_params.category_id
        with :city_id, search_params.city_id if search_params.city_id
        with :state, search_params.state if search_params.state

        any_of do
          any_of do
            search_params.ranges_for_numeric.each do |k, v|
              if v.any?
                all_of do
                  with :property_id, k
                  with :numeric_values, v[0]..v[1]
                end
              end
            end
          end

          with :list_item_ids, search_params.list_items if search_params.list_items
          with :hierarch_list_item_id, search_params.hierarch_list_items if search_params.hierarch_list_items
        end
      end

      Kaminari.paginate_array(
        search.results.map(&:organization).compact.uniq)
        .page(search_params.page).per(Organization.default_per_page)
    end
  end

  class ManageOrganizationSearcher < Searcher
    def search
      Organization.search do
        fulltext search_params.text if search_params.text
        with :state, search_params.state unless ['all', '', nil].include? search_params.state
        paginate page: search_params.page, per_page: Organization.default_per_page
      end.results
    end
  end
end

