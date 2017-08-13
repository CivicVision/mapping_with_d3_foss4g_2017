(function() {
  window.isLoggedIn = function() {
    if (window.drip.currentVisitor.email) {
      return window.trackEvent('Visited - Logged in - ' + document.title, {});
    } else {
      return window.location = '/mapping_with_d3_foss4g_2017/challenges?l=f';
    }
  };

  $(function() {
    if ($('.login-required').length > 0) {
      if (window.drip) {
        return window.drip.addCallback(window.isLoggedIn);
      } else {
        return window.location = '/mapping_with_d3_foss4g_2017/challenges?l=f';
      }
    }
  });

}).call(this);
