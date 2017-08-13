(function() {
  $(function() {
    if ($('.solution').length > 0) {
      return $('a.show-solution').click(function() {
        var solutionId;
        solutionId = this.getAttribute('data-id');
        window.trackEvent('Opened Solution', {
          title: document.title,
          excercise: solutionId
        });
        return $('#' + solutionId).show();
      });
    }
  });

}).call(this);
