window.onload = function() {
  if ($('#vue-form_organization').length) {
    Vue.component('property-component', {
      template: '#property-template',
      props: {
        value: Object,
        index: Number,
        category_property: Object,
        list_items: Array,
        edit_mode: Boolean,
        root_hierarch_list_items: Array,
        hierarch_list_items_init: Array
      },

      data: function() {
        return {
          hierarch_list_items: this.hierarch_list_items_init
        }
      },

      methods: {
        set_hierarch_list_items: function(parent_id) {
          if(parent_id == undefined) {
            that.hierarch_list_items = [];
            return 0;
          }
          var that = this;
          $.ajax({
            method: 'GET',
            url: '/categories/get_hierarch_list_items',
            data: {
              id: parent_id
            },
            success: function(res) {
              that.hierarch_list_items = res.hierarch_list_items;
            },
            error: function(res) {
              that.hierarch_list_items = []
            }
          })
        },
      }
    });

    var form_organization = new Vue({
      el: '#vue-form_organization',
      data: {
        organization: {
          category: {},
          values: []
        },
        list_items: [],
        edit_mode: false,
        category_properties: [],
        root_hierarch_list_items: [],
        errors: {},
        city_slug: $('#city_slug').val()
      },

      mounted: function() {
        if($('#organization_category_id').val())
          this.setCategory($('#organization_category_id').val())
      },

      methods: {
        get_hierarch_list_items: function(parent_id) {
          if(Number(parent_id) == 0 || isNaN(parent_id))
            return [];
          var that = this;
          var result = [11];
          $.ajax({
            method: 'GET',
            async: false,
            url: '/categories/get_hierarch_list_items',
            data: {
              id: parent_id
            },
            success: function(res) {
              result = res.hierarch_list_items;
            },
          });
          return result;
        },

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

        get_value: function(store, property_id, name_value) {
          var res = '';
          $.each(store, function(i, value) {
            if(value.property_id == property_id) {
              res = value[name_value];
            }}
          );
          if(name_value == 'list_item_ids' && (res == undefined || res == ''))
            res = [];
          return res;
        },

        get_id: function(store, property_id) {
          var res = '';
          $.each(store, function(i, value) {
            if(value.property_id == property_id) {
              res = i;
            }}
          );
          return res;
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
              $('#organization_category_id').val(res.category.id);
              store = JSON.parse($('#store_organization').html());
              console.log(store);
              store_errors = JSON.parse($('#store_organization_errors').html());
              that.organization.category = res.category;
              that.organization.values = [];
              res.properties.forEach(function(property) {
                that.organization.values.push({
                  property: property,
                  property_id: property.id,
                  id: that.get_id(store, property.id),
                  string_value: that.get_value(store, property.id, 'string_value'),
                  integer_value: that.get_value(store, property.id, 'integer_value'),
                  float_value:  that.get_value(store, property.id, 'float_value'),
                  boolean_value:  that.get_value(store, property.id, 'boolean_value'),
                  list_item_id:  that.get_value(store, property.id, 'list_item_id'),
                  list_item_ids:  that.get_value(store, property.id, 'list_item_ids'),
                  root_hierarch_list_item_id: that.get_value(store, property.id, 'root_hierarch_list_item_id'),
                  hierarch_list_item_id: that.get_value(store, property.id, 'hierarch_list_item_id'),
                  errors: store_errors[property.title]
                });
              });
              that.list_items = res.list_items;
              if($('#edit_mode').length)
                that.edit_mode = true;
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
