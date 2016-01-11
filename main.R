#CarJAn
#Careli Caballero, Jan Droesen
# 08/01/2016

#LIbraries required
library(rgdal)
library(raster)
#check if we are working in the correct directory
getwd()


source('R/calcNDVI.R')
source('R/difNDVI.R')
source('R/calcNDVI.R')

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

#Calculate NDVIs  Landsat 8(2014): Red = band 4 (layer 5) and NIR = band 5 (layer 6)
#and Landsat 5(1990): Red = band 3 (layer 6) and NIR = band 4 (layer 7)

ndvi1990 <- overlay(x=rstack1990[[6]], y=rstack1990[[7]], fun=ndvOver)
ndvi2014 <- overlay(x=rstack2014[[5]], y=rstack2014[[6]], fun=ndvOver)

#plot intermediairy results
plot(ndvi1990)
plot(ndvi2014)

#extract the cloud mask from layers (layer 1)
fmask1990 <- rstack1990[[1]]
fmask2014 <- rstack2014[[1]]

cloudfree1990 <- cloud2NA(ndvi1990, fmask1990)
cloudfree2014 <- cloud2NA(ndvi2014, fmask2014)

# Apply the function on the two raster objects using overlay
#CloudFree1990 <- calc(x = rmcloud_1990, y = fmask1990, fun = cloud2NA)
#CloudFree2014 <- cal(x = rmcloud_2014, y = fmask2014, fun = cloud2NA)

plot(cloudfree1990)
plot(cloudfree2014)

#Substraction of 1990 from 2014

NDVIdiff <- NDVIdiff(cloudfree2014,cloudfree1990)
#plot with in yellow small changes, in red a decrease in NDVI values and in green an increase of NDVI values
breakpoints <- c(-1.5, -0.2, 0.2, 1.5)
colors <- c("red", "yellow", "green")
plot(NDVIdiff, breaks=breakpoints, col = colors)
