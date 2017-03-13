function init_vue_service_packs() {
  Vue.component('pack_template', {
    template: '#one_pack',
    props: {
      pack: Object
    },
    data: function() {
      return {
        duration: 6,
        organization_id: $('#storage').data('organization-id')
      }
    },
    computed: {
      total_price: function(){
        if(this.duration >= 1 && this.duration < 6)
          return this.pack.price_for_month * this.duration
        else if(this.duration == 6)
          return this.pack.price_for_six_months
        else if(this.duration > 6 && this.duration < 12)
          return this.pack.price_for_six_months + (this.duration - 6) * this.pack.price_for_month
        else if(this.duration == 12)
          return this.pack.price_for_year
      },
      link: function() {
        return '/payments/create?' +
          '&amount=' +  this.total_price +
          '&organization_id=' + this.organization_id +
          '&paymentable_type=ServicePack' +
          '&paymentable_id=' + this.pack.id +
          '&details=' + 'Покупка пакета на ' + this.duration + ' месяцев.'
      }
    }
  });

  var service_packs = new Vue({
    el: '#vue-service_packs',
    data: {
      service_packs: []
    },

    mounted: function() {
      var that = this;
      $.ajax({
        method: 'GET',
        url: '/organizations/service_packs.json',
        success: function(res) {
          that.service_packs = res;
        }
      })

    }
  })
}
