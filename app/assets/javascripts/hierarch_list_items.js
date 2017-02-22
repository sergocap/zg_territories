init_hierarch_list_items = function() {
  $('.js-parent_hli').change(function(){
    var parent_id = $(this).val();
    var that = this;
    var wrapper = $(this).closest('.wrapper_hierarch_list_items');
    children = $(wrapper).find('.js-children_hli');
    $.ajax({
      method: 'GET',
      url: '/categories/get_hierarch_list_items',
      data: {
        id: parent_id
      },
      success: function(res) {
        children.empty();
        var data = res.hierarch_list_items;
        data.forEach(function(item) {
          children.append("<option value='" + item.id + "'>" + item.title);
        })
      }
    })
  })
}

