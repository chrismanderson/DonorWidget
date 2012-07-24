# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#submit-project').addClass('disabled')
  $('#spinner').hide()
  $('.pjax').pjax('[data-pjax-container]')
  $(':radio').live('change', ->
    $(this).closest('form.edit_widget').submit()
  )

  $('#widget_url').blur (event) ->
    console.log $(this).val()
    validateDonorsURL($(this).val()) unless $(this).val() == ''

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
          $('#status').text ""
          $('#input_field').removeClass("error").addClass("success"); 
          $('#spinner').hide()
        else
          $('#status').text "Sorry, we couldn't find a project at that link."
          $('#spinner').hide()
          $('#input_field').removeClass("success").addClass("error"); 
    else
      $('#status').text "Please enter in a correct DonorsChoose link."
      $('#input_field').removeClass("success").addClass("error");
      $('#spinner').hide()

