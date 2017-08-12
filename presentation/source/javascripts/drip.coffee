class @Drip
  constructor: () ->
    @currentVisitor = {}
    @isAnonymous = true
    @callbacks = []
    @personalizedCallbacks = []

  addPersonalizedCallback: (callback) ->
    @personalizedCallbacks.push(callback)

  addCallback: (callback) ->
    @callbacks.push(callback)

  setCallbacks: (callbacks) ->
    @callbacks = callbacks

  hasTag: (tag) ->
    tag in @currentVisitor.tags

  attr: (attr) ->
    @currentVisitor.customFields[attr]

  sendEvent: (eventName, amount) ->
    value = {}
    if(amount)
      value.value = amount
    _dcq.push(["track", eventName, value])

  subscribe: (campaignId, payload) ->
    _dcq.push(["subscribe", { campaign_id: campaignId, fields: payload}])


  callCallbacks: (callbacks) ->
    callbacks.forEach (callback) ->
      callback.call()

  visitorUpdated: ->
    @callCallbacks(@personalizedCallbacks)

  dripResponse: (payload) ->
    if payload.success
      @isAnonymous = payload.anonymous
      unless @isAnonymous
        @currentVisitor.uuid = payload.visitor_uuid
        @currentVisitor.email = payload.email
        @currentVisitor.tags = payload.tags
        @currentVisitor.customFields = payload.custom_fields
        @visitorUpdated()
      @callCallbacks(@callbacks)

class ReplaceContent
  replace: (cssPath, content) ->
    $(cssPath).html(content)

class SanDiego extends ReplaceContent
  update: =>
    if window.drip.hasTag('NGO') and window.drip.attr('Location') == 'San Diego'
      @replace('#welcome h2', 'Data Consultancy for Social Good in San Diego')


window.redirect = () ->
  if window.redirectToNewLocation
    window.location = window.redirectToNewLocation

identify = () ->
  query = $.querystring
  if query && query.email
    _dcq.push(["identify", {email: query.email, success: window.drip.dripResponse.bind(window.drip)}])
  else
    _dcq.push(["identify", {success: window.drip.dripResponse.bind(window.drip)}])

window.mixpanel_identify = () ->
  if window.hasOwnProperty('mixpanel')
    mixpanel.identify(window.drip.currentVisitor.uuid)
    mixpanel.people.set({
      "$email": window.drip.currentVisitor.email
    })
    window.trackEvent('Visited - '+document.title, {})

$ ->
  window.drip = new Drip()
  window.drip.setCallbacks([window.redirect])
  window.drip.addPersonalizedCallback(window.mixpanel_identify)
  #sd = new SanDiego()
  #window.drip.setCallbacks([sd.update])
  identify()
