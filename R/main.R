#CarJAn
#Careli Caballero, Jan Droesen
# 08/01/2016

#LIbraries required
library(rgdal)
library(raster)
#check if we are working in the correct directory
getwd()

#downloading the data
download.file(url='https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0', destfile='Wageningen8.tar', method='wget')
untar(tarfile='Wageningen8.tar')
download.file(url='https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0', destfile='Wageningen5.tar', method='wget')
untar(tarfile='Wageningen5.tar')

#check the file names, and resolution/projection. And check whether resolution/extent/projection is the same
GDALinfo("LC81970242014109LGN00_sr_band4.tif")
GDALinfo("LT51980241990098KIS00_sr_band3.tif")

# create list of files for the two images
LS1990 <- list.files(pattern = glob2rx('LT5*.tif'), full.names = TRUE)
LS2014 <- list.files(pattern = glob2rx('LC8*.tif'), full.names = TRUE)
#make raster stacks
rbrick1990 <- brick(LS1990)
rstack2014 <- stack(LS2014)
rstack1990
rstack2014
#give same extent
LS2014_newex <-setExtent(rstack2014, rstack1990, snap=TRUE)
extent (rstack2014) <- rstack1990
LS2014_newex
rstack2014
#make raster bricks
rbrick1990 <- brick(LS2014_newex)
rbrick2014 <- brick(rstack2014)
rbrick1990
rbrick2014

#Calculate NDVIs  Landsat 8(2014): Red = band 4 (layer 5) and NIR = band 5 (layer 6) 
#and Landsat 5(1990): Red = band 3 (layer 6) and NIR = band 4 (layer 7)


source(calculateNDVI)
ndvOver(1990l3, 1990l4)
ndvOver(2014l3, 2014l4)

#extract the cloud mask from layers (layer 1)
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}
cloudfree1990 <- cloud2NA(rbrick1990,rbrick1990[[1]])
cloudfree2014 <- cloud2NA(rbrick2014,rbrick2014[[1]])
plot(cloudfree1990)
plot(cloudfree2014)

NDVI1990 <- ndvOver(cloudfree1990[[6]], cloudfree1990[[7]])	
NDVI2014 <- ndvOver(cloudfree2014[[5]], cloudfree2014[[6]])
#plot both NDVI images
plot(NDVI1990)
plot(NDVI2014)

#Substraction two NDVI layers of now and thirty years ago
NDVIdiff <-(NDVI2014-NDVI1990)
#Output
plot(NDVIdiff)
									 