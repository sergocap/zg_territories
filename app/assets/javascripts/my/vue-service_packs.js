function init_vue_service_packs() {
  Vue.component('pack_template', {
    template: '#one_pack',
    props: {
      pack: Object,
      info: Object
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
          '&duration=' + this.duration +
          '&details=' + 'Покупка пакета ' + this.pack.title + ' на '+ this.duration + ' мес..'
      }
    }
  });

  var service_packs = new Vue({
    el: '#vue-service_packs',
    data: {
      service_packs: [],
      organization_id: $('#storage').data('organization-id'),
      infos: []
    },

    methods: {
      get_info: function(pack_id) {
        var res = this.infos.filter(function(value) {
          return value.id == pack_id
        })
        return res[0];
      }
    },

    mounted: function() {
      var that = this;
      $.ajax({
        method: 'GET',
        url: '/organizations/service_packs.json',
        data: {
          organization_id: this.organization_id
        },
        success: function(res) {
          that.service_packs = res.service_packs;
          that.infos = res.infos;
        }
      })
    }
  })
}
