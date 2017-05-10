@init_image_upload = ->
  $(document).on 'click', '.js-image_button', ->
    $(this).next().find('input').click()

  $(document).on 'change', '.js-image_input', (e) ->
    preview = $(this).parent().next()
    file = $(this).prop('files')[0]
    if file.type.split('/')[0] == 'image'
      reader = new FileReader()
      reader.onload = (e) ->
        preview.css('max-height', '200px')
        preview.attr('src', e.target.result)
      reader.readAsDataURL(file)
    else
      alert 'Выберите картинку'



