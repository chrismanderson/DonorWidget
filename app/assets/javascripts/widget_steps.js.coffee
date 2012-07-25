# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  handler = (event) ->
    event.preventDefault()
    validateDonorsURL($('#widget_url').val())
    console.log "the links, they do nothing!"

  $("#new_widget").bind('submit', handler)

  $("#new_widget").submit (e) ->
    validateDonorsURL($('#widget_url').val())

  $('#submit-project').addClass('disabled')
  $('#spinner').hide()
  $('.pjax').pjax('[data-pjax-container]')
  $(':radio').live('change', ->
    $(this).closest('form.edit_widget').submit()
  )

  $('#widget_url').blur (event) ->
    console.log $(this).val()
    validateDonorsURL($(this).val())

  $('.random_project').on 'click', (event) ->
    event.preventDefault;
    $('#spinner').show()
    $.getJSON '/projects/random', (data) ->
      $('#widget_url').val data.url
      validateDonorsURL(data.url)
      $('#spinner').hide()

  validateDonorsURL = (url) ->
    $('#spinner').show()
    pattern = ///
      \d{2,}
    ///
    id = url.match(pattern)
    console.log id
    if id != null && url.match('donorschoose.org')
      $.getJSON "/projects/#{id}", (data) ->
        if data.status == 'success'
          $('#submit-project').removeClass('disabled')
          $('#status').removeClass("error").addClass("success");
          $('#status').text "We found a project! Click next!"
          $('#input_field').removeClass("error").addClass("success"); 
          $('#spinner').hide()
          $("#new_widget").unbind('submit', handler)
        else
          $('#status').removeClass("success").addClass("error");
          $('#status').text "Sorry, we couldn't find a project at that link."
          $('#spinner').hide()
          $('#input_field').removeClass("success").addClass("error"); 
          $("#new_widget").bind('submit', handler)
          false
    else
      $('#status').removeClass("success").addClass("error");
      $("#new_widget").bind('submit', handler)
      $('#status').text "Please enter in a correct DonorsChoose link."
      $('#input_field').removeClass("success").addClass("error");
      $('#spinner').hide()
      false

