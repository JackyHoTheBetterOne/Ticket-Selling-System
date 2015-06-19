do (window) ->

  class BaseController

    _defaultErrorMsg: ->
      alert("Some Error Occured Please Refresh Page")
      console.log("debug: ajax error callback")

    _timeOutMsg: ->
      alert("TimeOut Check your internet Connection")
      console.log("debug: connection timed out")

    _ajaxSuccess: (jqXhr, callback) =>
      @_updateModelCollections(jqXhr?.recordData)
      callback?(jqXhr)

    _sendAjax: (config)->
      $.ajax
        defaultError: @_defaultErrorMsg
        timeOut:      @_timeOutMsg
        url:          config.url
        method:       config.method
        data:         config.data
        dataType:     "JSON"
        timeout:      5000
        success: (jqXhr) ->
          if config.success? then config.success(jqXhr, config.successCallback)  else null
        error: (jqXhr, textStatus, errorThrown) ->
          return @timeOut() if textStatus == 'timeout'
          if config.error?    then config.errorCallback(jqXhr, config.errorCallback) else @defaultError()
        complete: (jqXhr) ->
          if config.complete? then config.completeCallback(jqXhr)                 else null


  class EventController extends BaseController
    _routes = Routes.Event

    index: (config)->
      @_sendAjax
        url             : @_routes.index()
        method          : "GET"
        data            : config?.data
        success         : @_ajaxSuccess
        successCallback : config.callback

    show: (config) ->
      @_sendAjax
        url             : @_routes.show config.id
        method          : "GET"
        data            : config?.data
        success         : @_ajaxSuccess
        successCallback : config.callback

    new: (config) ->
      @_sendAjax
        url             : @_routes.new()
        method          : "POST"
        data            : {}
        success         : @_ajaxSuccess
        successCallback : config.callback

    create: (config) ->
      @_sendAjax
        url             : @_routes.create()
        method          : "POST"
        data            : {}
        success         : @_ajaxSuccess
        successCallback : config.callback

  window.Controller =
    Event: new EventController