#CarJAn
#Careli Caballero, Jan Droesen
# 08/01/2016

#LIbraries required
library(rgdal)
library(raster)
#check if we are working in the correct directory
getwd()


source('R/calcNDVI.R')
source('')

#downloading the data
download.file(url='https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0', destfile='Wageningen8.tar', method='wget')
untar(tarfile='Wageningen8.tar')
download.file(url='https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0', destfile='Wageningen5.tar', method='wget')
untar(tarfile='Wageningen5.tar')

# create list of files for the two images
LS1990 <- list.files(pattern = glob2rx('LT5*.tif'), full.names = TRUE)
LS2014 <- list.files(pattern = glob2rx('LC8*.tif'), full.names = TRUE)
#make raster stacks
rstack1990 <- stack(LS1990)
rstack2014 <- stack(LS2014)

#give same extent
#LS2014_newex <-setExtent(rstack2014, rstack1990, snap=TRUE)
#extent (rstack2014) <- rstack1990
#LS2014_newex
#rstack2014
#make raster bricks

#Calculate NDVIs  Landsat 8(2014): Red = band 4 (layer 5) and NIR = band 5 (layer 6)
#and Landsat 5(1990): Red = band 3 (layer 6) and NIR = band 4 (layer 7)
source('home/user/git/geoScripting/NDVIdiff/R/calcNDVI.R')
ndvOver <- function(x, y) {
	ndvi <- (y - x) / (x + y)
	return(ndvi)
}
ndvi1990 <- overlay(x=rstack1990[[6]], y=rstack1990[[7]], fun=ndvOver)
ndvi2014 <- overlay(x=rstack2014[[5]], y=rstack2014[[6]], fun=ndvOver)

#plot intermediairy results
plot(ndvi1990)
plot(ndvi2014)

#extract the cloud mask from layers (layer 1)
fmask1990 <- rstack1990[[1]]
fmask2014 <- rstack2014[[1]]
cloud2NA <- function(x, y){
x[y != 0] <- NA
return(x)
}

cloudfree1990 <- cloud2NA(ndvi1990, fmask1990)
cloudfree2014 <- cloud2NA(ndvi2014, fmask2014)

# Apply the function on the two raster objects using overlay
#CloudFree1990 <- calc(x = rmcloud_1990, y = fmask1990, fun = cloud2NA)
#CloudFree2014 <- cal(x = rmcloud_2014, y = fmask2014, fun = cloud2NA)

plot(cloudfree1990)
plot(cloudfree2014)

#Substraction two NDVI layers of now and thirty years ago
NDVIdiff <- function(x, y) {
	ndvidif <- (x - y)
	return(ndvidif)
}

NDVIdiff <- NDVIdiff(cloudfree2014,cloudfree1990)
#Output
plot(NDVIdiff)
plot(NDVIdiff, col = gray.colors(10, start = -1.5, end = 1.5, gamma = 2.2, alpha = NULL))
