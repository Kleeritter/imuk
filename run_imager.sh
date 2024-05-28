    . ~/.bashrc_miniconda3
conda activate imuk
export PYTHONPATH=$PYTHONPATH:/localdata/weathermaps/imuk
#mamba install multiprocess -y 
start=0
end=168
stepsize=3
path_input=/localdata/weathermaps/imuk
path_output=/localdata/weathermaps/webside/gross
path_output_stationt=/localdata/weathermaps/stationmaps
path_input_meteogram=/localdata/weathermaps/data/meteogram
path_output_meteogram=/localdata/weathermaps/meteogram


path_output_klein=/localdata/weathermaps/webside/klein
path_output_4panel=/localdata/weathermaps/webside/4panel
xdim_1=945
ydim_1=480

xdim_2=700
ydim_2=420


xdim_3=350
ydim_3=210

### GPH_MAPS

model=icon


python /localdata/weathermaps/imuk/products/gph_maps/wind_300.py $xdim_1 $ydim_1 $path_output $path_input $start $end $stepsize

echo "300  finished"

python /localdata/weathermaps/imuk/products/gph_maps/gph_temp_850.py $xdim_1 $ydim_1 $path_output $path_input $start $end $stepsize
echo "850  finished"
python /localdata/weathermaps/imuk/products/gph_maps/gph_temp_500.py $xdim_1 $ydim_1 $path_output $path_input $start $end $stepsize
echo "500  finished"
python /localdata/weathermaps/imuk/products/gph_maps/gph_rh_700.py $xdim_1 $ydim_1 $path_output $path_input $start $end $stepsize
echo "700  finished"
python /localdata/weathermaps/imuk/products/gph_maps/bd_sw_meteosat.py $xdim_1 $ydim_1 $path_output $path_input $start $end $stepsize $model

python /localdata/weathermaps/imuk/ressources/tools/imageresizer.py $path_output_klein $path_output_4panel $path_output $xdim_3 $ydim_3 $xdim_2 $ydim_2
echo "resizing  finished"


### METEOGRAMM

echo "start Meteogramms"

python /localdata/weathermaps/imuk/products/meteogram/meteogram.py $path_input_meteogram $path_output_meteogram


echo "Meteogramms finished"



##Stationmaps
python /localdata/weathermaps/imuk/products/stationmaps/stationmap_metpy.py $path_input $path_output_stationt