# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

  
$ ->
  is_tint = (color) ->
    red = color[1..2]
    green = color[3..4]
    blue = color[5..6]
    total = parseInt(red, 16) + parseInt(green, 16) + parseInt(blue, 16)
    total > 383 ? true : false

  $(".colorpicker").colorpicker().on "changeColor", (ev) ->
    newColor = ev.color.toHex()
    $('#dc-donors-choose-widget').parent().css('background-color', newColor)
    $('#dc-donors-choose-widget').css('background-color', newColor)
    if is_tint newColor
      $('#dc-donors-choose-widget').css('color', '#000000')
    else
      $('#dc-donors-choose-widget').css('color', '#ffffff')