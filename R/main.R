library(rgdal)
library(raster)
#check if working directory VegetationChangeWageningen
getwd()

#downloading the data
 <- download.file(url='https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0', destfile='Wageningen8.tar', method='wget')
untar(tarfile='Wageningen8.tar')
download.file(url='https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0', destfile='Wageningen5.tar', method='wget')
untar(tarfile='Wageningen5.tar')

#check the file names, and resolution/projection. And check whether resolution/extent/projection is the same
#if not the same  -> resample, reproject, intersect
GDALinfo("LC81970242014109LGN00_sr_band4.tif")
GDALinfo("LT51980241990098KIS00_sr_band3.tif")

# create list of files for the two images
Landsat1990 <- list.files(pattern = glob2rx('LT5*.tif'), full.names = TRUE)
Landsat2014 <- list.files(pattern = glob2rx('LC8*.tif'), full.names = TRUE)

stack()

# make raster layers
rasterlayers1990 <- lapply(Landsat1990, raster)
rasterlayers2014 <- lapply(Landsat2014, raster)
rasterlayers2014
rasterlayers1990
<- stack()
stack()

#Calculate NDVI  Landsat 8: red = band 4 and NIR = band 5 Landsat 5/7: red 3 and nir 4
ndvOver <- function(x, y) {
	ndvi <- (y - x) / (x + y)
	return(ndvi)
}
NDVI2014 <- ndvOver(rasterlayers2014[[5]], rasterlayers2014[[6]])
NDVI1990 <- ndvOver(rasterlayers1990[[6]], rasterlayers1990[[7]])	


	5 and 6 for 2014
6 and 7 for 1990
#give the same extent for both images
lapply(rasterlayers2014, intersect(rasterlayers1990, rasterlayers2014))
for i 1:nlayers(rasterlayers2014)
	intersect(rasterlayers[1], rasterlayers[i])




#ndvi3 <- overlay(x=gewata[[3]], y=gewata[[4]], fun=ndvOver)




#plot both NDVI maps

#cloud mask from layer 7?...
cloud1 <- Wageningen2015[[7]]
cloud[cloud==0] <- NA
#
plotRGB(tahiti, 3,4,5)
plot(cloud, add = TRUE, legend = FALSE)
fmask <- Wageningen2015[[7]]
Wageningen.. <- dropLayer(Wageningen2015, 7)
Wageningen.. [fmask != 0]<- NA 
cloud2NA <- function(x, y){
	x[y != 0] <- NA
	return(x)
}
plotRGB(tahitiCloudFree, 3,4,5)

#to programmatically extract the files from the archive
#untar()

getwd()
#Substraction two NDVI layers of now and thirty years ago
difference <- calc(layer1-layer
									 #Output
									 plot(difference)