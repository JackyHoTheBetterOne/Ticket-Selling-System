# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  SEAT_SELECTOR = ((global, $) ->
    circle_mouseover_color = '#696969'
    circle_original_color = '#3b77bf'
    svg = $("#seatty-for-real")
    box = $(".text-box-bubble")
    event_name = $("#event_name").data("name")
    selected_seats = []
    seat_class_recontruction = (circle) ->
        basic_klass = "seat-circle"
        row_klass = "row-" + $(circle).data('row')
        column_klass = "column-" + $(circle).data('column')
        return basic_klass + " " + row_klass + " " + column_klass
    return {
      events: {
        circle_mouseenter: (event) ->
          circle = this
          $(circle).attr('fill', circle_mouseover_color)
          SEAT_SELECTOR.timer = setTimeout (->
            position = $(circle).offset()
            cX = position.left
            cY = position.top
            x = cX - 22
            y = cY - 67
            $(box).css({top:y, left: x, opacity: 1})
          ), 500
        circle_mouseleave: (event) ->
          circle = this
          if $(circle).attr('class').indexOf('selected_seat') is -1
            $(circle).attr('fill', circle_original_color) 
          window.clearTimeout(SEAT_SELECTOR.timer)
          $(box).css("opacity", "0")
        circle_click: (event) ->
          circle = this
          klass = $(circle).attr('class')
          if klass.indexOf('selected_seat') is -1
            $(circle).attr('class', klass + " selected_seat")
            selected_seats.push(circle)
          else
            $(circle).attr('class', seat_class_recontruction(circle))
            $(circle).attr('fill', circle_original_color)
            index = selected_seats.indexOf(circle)
            selected_seats.splice(index,1)
        submit_seats: (event) ->
          i = 0
          length = selected_seats.length
          params_obj = []
          while i < length
            seat = selected_seats[i]
            seat_name = $(seat).data("row").toString() + $(seat).data("column").toString()
            params_obj.push(seat_name)
            i++
          console.log(params_obj)
          $.ajax
            url: "/events/" + event_name + "/seat_selection"
            method: "post"
            data: {
              seat_selection: params_obj,
              event_name: event_name
            }
            success: (response) ->
              console.log(response)
            error: () ->
              alert('Cannot send the seat selection')

      }
    }
  )(window, jQuery)
  $('.seat-circle').on(
    'mouseenter.circle_selection', SEAT_SELECTOR.events.circle_mouseenter
  ).on(
    'mouseleave.circle_selection', SEAT_SELECTOR.events.circle_mouseleave
  )
  $('.seat-circle').on('click.select', SEAT_SELECTOR.events.circle_click)
  $('.submit-seats').on('click.submit_seats', SEAT_SELECTOR.events.submit_seats)

