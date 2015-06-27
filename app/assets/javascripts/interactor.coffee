window.CHART_INTERACTOR = {
  circle_position_translation_to_box: (circle, box, x_adj, y_adj)->
    position = $(circle).position()
    cX = position.left
    cY = position.top
    x = cX - x_adj
    y = cY - y_adj
    $(box).css({top:y, left: x, opacity: 1, 'z-index': 5})
  box_hide: (box) ->
    $(box).css({"opacity":"0", 'z-index': '-1'})
  seat_class_recontruction: (circle) ->
    basic_klass = "seat-circle"
    row_klass = "row-" + $(circle).data('row')
    column_klass = "column-" + $(circle).data('column')
    return basic_klass + " " + row_klass + " " + column_klass
  mouseclick_circle: (func, circle, true_callback, false_callback, default_color) ->
    circle = obj.circle
    if obj.func.call()
      klass = $(circle).attr('class')
      $(circle).attr('class', klass + " selected-seat")
      obj.true_callback.call()
    else
      $(circle).attr('class', window.CHART_INTERACTOR.
        seat_class_recontruction(circle))
      $(circle).attr('fill', default_color)
      obj.false_callback.call()
}
