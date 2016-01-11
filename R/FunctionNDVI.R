#check if working directory VegetationChangeWageningen
getwd()

#downloading the data

download.file(url='https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz?dl=0', destfile='Wageningen8.zip', method='wget')
unzip(zipfile='Wageningen.zip')
download.file(url='https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz?dl=0', destfile='Wageningen5.zip', method='wget')
unzip(zipfile='Wageningen5.zip')


list.files('data/', pattern = glob2rx('*.tif'), full.names = TRUE)

brickWag <- brick('.../.tif')

getwd()
ndvi3 <- overlay(x=gewata[[3]], y=gewata[[4]], fun=ndvOver)
#check the file names, and resolution/projection. And check whether resolutoion/extent/projection is the same
#if not the same  -> resample, reproject, intersect

#cropping data
intersect(two layer)

#Calculate NDVI  Landsat 8: red = band 4 and NIR = band 5 Landsat 5/7: red 3 and nir 4
ndvOver <- function(x, y) {
	ndvi <- (y - x) / (x + y)
	return(ndvi)
}
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