$ ->
  if $('.solution').length > 0
    $('a.show-solution').click( () ->
      solutionId = this.getAttribute('data-id')
      window.trackEvent('Opened Solution', {title: document.title, excercise: solutionId})
      $('#'+solutionId).show()
    )

