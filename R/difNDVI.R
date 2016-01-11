#Substraction two NDVI layers of now and thirty years ago
NDVIdiff <- function(x, y) {
	ndvidif <- (x - y)
	return(ndvidif)
}