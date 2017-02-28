module Searchers
  class Searcher
    attr_accessor :search_params

    def initialize(args = {})
      @search_params = Hashie::Mash.new args
    end

    def collection
      search.results
    end
  end

  class OrganizationSearcher < Searcher
    private
    def search
      search_params.list_items.reject!(&:empty?) if search_params.list_items
      search_params.hierarch_list_items.reject!(&:empty?) if search_params.hierarch_list_items
      Organization.search do
        fulltext search_params.text if search_params.text
        with :category_id, search_params.category_id if search_params.category_id
        with :city_id, search_params.city_id if search_params.city_id
        with :state, search_params.state if search_params.state

        any_of do
          with :list_item_ids, search_params.list_items if search_params.list_items
          with :hierarch_list_item_ids, search_params.hierarch_list_items if search_params.hierarch_list_items
        end

        paginate page: search_params.page, per_page: Organization.default_per_page
      end
    end
  end

  class ManageOrganizationSearcher < Searcher
    private
    def search
      Organization.search do
        fulltext search_params.text if search_params.text
        with :state, search_params.state if !search_params.state.try(:empty?) && search_params.state != 'all'
        paginate page: search_params.page, per_page: Organization.default_per_page
      end
    end
  end
end

