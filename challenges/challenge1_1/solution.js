(function() {
  var center, countries, height, path, projection, scale, svg, width;

  width = 300;

  height = 400;

  center = [5, 70];

  scale = 600;

  projection = d3.geo.mercator().scale(scale).translate([width / 2, 0]).center(center);

  path = d3.geo.path().projection(projection);

  svg = d3.select("#map").append("svg").attr("height", height).attr("width", width);

  countries = svg.append("g");

  d3.json("data/eu.geojson", function(data) {
    return countries.selectAll('.country').data(data.features).enter().append('path').attr('class', 'country').attr('d', path);
  });

}).call(this);
