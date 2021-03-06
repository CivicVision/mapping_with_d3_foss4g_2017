width = 300
height = 400
center = [5,70]
scale = 600
projection = d3.geo.mercator().scale(scale).translate([width/2, 0]).center(center)
path = d3.geo.path().projection(projection)

svg = d3.select("#map").append("svg").attr("height", height).attr("width", width)
countries = svg.append("g")

d3.json "data/eu.json", (data) ->
  countries.selectAll('.country')
  .data(topojson.feature(data, data.objects.europe).features)
  .enter()
  .append('path')
  .attr('class', 'country')
  .attr('d', path)
  .on("mousemove", (d) ->
    d3.select("#tooltip").style("left", (d3.event.pageX + 10) + "px")
    .style("top", (d3.event.pageY - 20) + "px")
  )
  .on("mouseover", (d) ->
    d3.select("#tooltip").html(d.properties.name).style("opacity",1)
  )
  return
