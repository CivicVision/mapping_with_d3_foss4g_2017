window.isLoggedIn = () ->
  if window.drip.currentVisitor.email
    window.trackEvent('Visited - Logged in - '+document.title, {})
  else
    window.location = '/mapping_with_d3_foss4g_2017/challenges?l=f'

$ ->
  if $('.login-required').length > 0
    if window.drip
      window.drip.addCallback(window.isLoggedIn)
    else
      window.location = '/mapping_with_d3_foss4g_2017/challenges?l=f'
