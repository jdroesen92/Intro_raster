#CalculateNDVI

#Calculate NDVIs  Landsat 8(2014): Red = band 4 (layer 5) and NIR = band 5 (layer 6) 
#and Landsat 5(1990): Red = band 3 (layer 6) and NIR = band 4 (layer 7)
ndvOver <- function(x, y) {
	ndvi <- (y - x) / (x + y)
	return(ndvi)
}