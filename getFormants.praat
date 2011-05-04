# This script loops over all the selected sounds in the Objects window,
# getting formant values at the mid point of the target interval.

targetTier = 1
targetInterval = 2

form Formant extraction parameters
	real Time_step_(s) 0.0 (= auto)
	natural Max_number_of_formants 5
	positive Maximum_formant_(Hz) 5500 (= adult female)
	positive Window_length_(s) 0.025
	positive Pre-emphasis_from_(Hz) 50
	positive Formants_to_measure 3 (= from 1 to this number)
endform

# make a series of indexes for your sounds
numberOfSounds = numberOfSelected ("Sound")
for i to numberOfSounds
	sound'i' = selected ("Sound", i)
endfor

clearinfo

# print "header" line
printline Sound'tab$'time'tab$'formant'tab$'value_Hz

# loop through sounds
for current to numberOfSounds
	select sound'current'
	soundName$ = selected$ ("Sound")
	# get time for measurement
	select TextGrid 'soundName$'
	timeStart = Get start point... targetTier targetInterval
	timeEnd = Get end point... targetTier targetInterval
	timeTarget = timeStart + (timeEnd - timeStart)/2

	# create Formant object for getting the measurement
	select Sound 'soundName$'
	To Formant (burg)... 'time_step' 'max_number_of_formants' 'maximum_formant' 'window_length' 'pre-emphasis_from'
	formants = selected ("Formant")



	# get values and print output
	select formants
	for currentFormant to formants_to_measure
		formantValue = Get value at time... 'currentFormant' 'timeTarget' Hertz Linear
		printline 'soundName$''tab$''timeTarget''tab$''currentFormant''tab$''formantValue'
	endfor
	
	# Clean up
	select formants
	Remove

endfor