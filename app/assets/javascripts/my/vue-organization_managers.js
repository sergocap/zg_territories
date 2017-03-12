function init_vue_organization_managers() {
  var managers = new Vue({
    el: '#vue-organization_managers',
    data: {
      managers: [],
      organization_id: $('#organization_data').data('organization-id'),
      new_manager: {
        email: ''
      }
    },

    methods: {
      addManagers: function() {
        var that = this;
        $.ajax({
          method: 'POST',
          url: '/organization_managers.json',
          data: {
            organization_id: that.organization_id,
            email: that.new_manager.email
          },
          success: function(res) {
            that.managers.push(res);
            that.new_manager.email = '';
          }
        })
      }
    },

    mounted: function() {
      var that = this;
      $.ajax({
        url: 'managers_for_organization.json',
        success: function(res) {
          that.managers = res.managers
        }
      })
    }
  })
}
