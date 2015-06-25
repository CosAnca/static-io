num = 4
square = (x) -> x * x

math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x

$(document).ready ->
	console.log('ceva')