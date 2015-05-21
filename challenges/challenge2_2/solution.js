(function() {
  var center, countries, distance, height, path, projection, rotate, scale, svg, tilt, width;

  width = 500;

  height = 400;

  center = [5, 70];

  scale = 550;

  distance = 1.1;

  rotate = [7, -50.3849401, -55];

  tilt = 20;

  projection = d3.geo.satellite().translate([width / 2, 0]).distance(distance).scale(scale).rotate(rotate).tilt(tilt);

  path = d3.geo.path().projection(projection);

  svg = d3.select("#map").append("svg").attr("height", height).attr("width", width);

  countries = svg.append("g");

  d3.json("data/eu.json", function(data) {
    return countries.selectAll('.country').data(topojson.feature(data, data.objects.europe).features).enter().append('path').attr('class', 'country').attr('d', path);
  });

}).call(this);
