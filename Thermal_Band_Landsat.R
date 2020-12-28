#########This code reads a high gain temperature band file from landsat 
#######and converts it to a temperature raster readable in ARCGIS
#######You need to download the following R libraries: raster and landsat and rgdal

library(raster)
#file with temperature band
f="LT50140322011211GNC01_B6.TIF"
#Here you are going to specify the filename and location like in the previous line and name it "f"



####Reading the temperature band file (f) and convert it to a raster and plot it to check it out
r <- raster(f) 
plot(r)



library(landsat)
####Converting to a matrix
p=as.matrix(r)
######Retieving the temperature in Kelvins
thermal=thermalband(p,6)
####Converting to Celsius
thermal=thermal-273.15


######Converting the thermal data into raster
l=raster(thermal,xmn=xmin(r),xmx=xmax(r),ymn=ymin(r),ymx=ymax(r))

####This part of the code is just for better visualization
filledContour(l,zlim=c(20,40),nlevels=6,color.palette=topo.colors)


#####Writing the raster in GeoTiff format
library(rgdal)
#####In filename you're gong to specify the name and location of the file.
#####In this case, the filename is Thermal62.tif
####and is located in the following directory: /Users/pedrosequera/Desktop/Landsat_Jose/
writeRaster(l,filename="Thermal_NewYork.tif",format="GTiff")

#####Writing the raster in RASTER format
writeRaster(l,filename="Thermal_NewYork.grd",format="raster")

