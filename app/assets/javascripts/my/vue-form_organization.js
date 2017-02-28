window.onload = function() {
  if ($('#vue-form_organization').length) {
    Vue.component('property-component', {
      template: '#property-template',
      props: {
        value: Object,
        index: Number,
        category_property: Object,
        list_items: Array,
        root_hierarch_list_items: Array,
      },

      data: function() {
        return {
          hierarch_list_items: []
        }
      },

      methods: {
        set_hierarch_list_items: function(parent_id) {
          var that = this;
          $.ajax({
            method: 'GET',
            url: '/categories/get_hierarch_list_items',
            data: {
              id: parent_id
            },
            success: function(res) {
              that.hierarch_list_items = res.hierarch_list_items;
            }
          })
        }
      }
    });

    var form_organization = new Vue({
      el: '#vue-form_organization',
      data: {
        organization: {
          title: '',
          address: '',
          city_id: $('#organization_city_id').val(),
          category_id: '',
          category: {},
          user_id: $('#organization_user_id').val(),
          values: []
        },
        list_items: [],
        category_properties: [],
        root_hierarch_list_items: [],
        errors: {},
        city_slug: $('#city_slug').val()
      },

      methods: {
        get_list_items: function(property_id) {
          filtered = this.list_items.filter(function(item) {
            return item.property_id == property_id;
          });
          return filtered;
        },

        get_category_property: function(property_id) {
          filtered = this.category_properties.filter(function(item) {
            return item.property_id == property_id;
          });
          return filtered[0];
        },

        get_root_hierarch_list_items: function(property_id) {
          filtered = this.root_hierarch_list_items.filter(function(item) {
            return item.property_id == property_id;
          });
          return filtered;
        },

        setCategory: function(id) {
          var that = this;
          $.ajax({
            method: 'GET',
            url: '/categories/get_by_id',
            data: {
              id: id
            },
            success: function(res) {
              that.organization.category = res.category;
              that.organization.category_id = res.category.id
              that.organization.values = [];
              res.properties.forEach(function(property) {
                that.organization.values.push({
                  property: property,
                  property_id: property.id,
                  string_value: '',
                  integer_value: '',
                  float_value: '',
                  boolean_value: '',
                  list_item_id: '',
                  list_item_ids: [],
                  root_hierarch_list_item_id: '',
                  hierarch_list_item_id: ''
                });
              });
              that.list_items = res.list_items;
              that.category_properties = res.category_properties;
              that.root_hierarch_list_items = res.root_hierarch_list_items;
            },
            error: function(res) {
              that.errors = res.responseJSON.errors
            }
          })
        },
      }
    });

    $('div.category_item').on('mouseover', function() {
      $(this).children('ul').css('display', 'block')
    });

    $('div.category_item').on('mouseleave', function() {
      $(this).children('ul').css('display', 'none')
    });
  }
}
