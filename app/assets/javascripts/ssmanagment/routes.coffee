window.Routes =
  Event:
    index:               -> "/ssmanagment"
    create:              -> "/ssmanagment/events/"
    new:                 -> "/ssmanagment/events/new"
    update:   (event_id) -> "/ssmanagment/events/#{event_id}"
    show:     (event_id) -> "/ssmanagment/events/#{event_id}"
    copy:     (event_id) -> "/ssmanagment/events/#{event_id}/copy"