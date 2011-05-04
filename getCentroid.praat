# This script loops over all the selected sounds in the Objects window,
# getting pitch values at every point market in the target tier.

targetTier = 1
targetInterval = 2

# make a series of indexes for your sounds
numberOfSounds = numberOfSelected ("Sound")
for i to numberOfSounds
	sound'i' = selected ("Sound", i)
endfor

clearinfo

# print "header" line
printline Sound'tab$'timeStart'tab$'timeEnd'tab$'centroid

# loop through sounds
for current to numberOfSounds
	select sound'current'
	soundName$ = selected$ ("Sound")
	# get times for segment
	select TextGrid 'soundName$'
	timeStart = Get start point... targetTier targetInterval
	timeEnd = Get end point... targetTier targetInterval

	# Extract segment and name
	select Sound 'soundName$'
	Extract part... timeStart timeEnd rectangular 1 no
	segment = selected ("Sound")

	# create Spectrum object for getting the measurement
	select segment
	To Spectrum... yes
	spect = selected ("Spectrum")

	# get centroid
	select spect
	centroid = Get centre of gravity... 2

	# print output to Info window
	printline 'soundName$''tab$''timeStart''tab$''timeEnd''tab$''centroid'
	
	# Clean up
	select segment
	plus spect
	Remove

endfor