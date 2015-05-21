(function() {
  var countries, height, path, svg, width;

  width = 300;

  height = 400;


  /* your code here */

  path = d3.geo.path().projection(projection);

  svg = d3.select("#map").append("svg").attr("height", height).attr("width", width);

  countries = svg.append("g");

  d3.json("data/eu.json", function(data) {
    countries.selectAll('.country').data(topojson.feature(data, data.objects.europe).features).enter().append('path').attr('class', 'country').attr('d', path);
  });

}).call(this);
