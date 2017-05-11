@init_image_upload = ->
  $(document).on 'click', '.js-image_button', ->
    $(this).next().find('input').click()

  $('.js-reset_main_photo').on 'click', ->
    $('#delete_image_input').val('1')
    $(this).css('display', 'none')
    $('.js-image_preview').attr('src', '')
    $('.js-image_preview').css({'display': 'none'})

  $(document).on 'change', '.js-image_input', (e) ->
    preview = $(this).parent().next()
    file = $(this).prop('files')[0]
    if file.type.split('/')[0] == 'image'
      reader = new FileReader()
      reader.onload = (e) ->
        preview.css({'display': 'inline-block', 'max-height': '200px'})
        preview.attr('src', e.target.result)
        $('#delete_image_input').val('')
        $('.js-reset_main_photo').css('display', 'inline-block')
      reader.readAsDataURL(file)
    else
      alert 'Выберите картинку'



