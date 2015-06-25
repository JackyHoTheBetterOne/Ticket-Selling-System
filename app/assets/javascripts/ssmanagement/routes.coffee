window.Routes =
  Event:
    index:               -> "/ssmanagement"
    create:              -> "/ssmanagement/events/"
    new:                 -> "/ssmanagement/events/new"
    update:   (event_id) -> "/ssmanagement/events/#{event_id}"
    show:     (event_id) -> "/ssmanagement/events/#{event_id}"
    copy:     (event_id) -> "/ssmanagement/events/#{event_id}/copy"