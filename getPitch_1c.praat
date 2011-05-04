# This script loops over all the selected sounds in the Objects window,
# getting pitch values at every point market in the target tier.

targetTier = 3
minPitch = 75
maxPitch = 400

# make a series of indexes for your sounds
numberOfSounds = numberOfSelected ("Sound")
for i to numberOfSounds
	sound'i' = selected ("Sound", i)
endfor

clearinfo

# print "header" line
printline Sound'tab$'time(sec)'tab$'pitch(Hz)

# loop through sounds
for current to numberOfSounds
	select sound'current'
	soundName$ = selected$ ("Sound")
	# get number of pitches to measure
	select TextGrid 'soundName$'
	numberOfPitches = Get number of points... targetTier
	# printline numberOfPitches = 'numberOfPitches'  # debugging example

	# create Pitch object for getting the measurement
	select Sound 'soundName$'
	To Pitch... 0 minPitch maxPitch

	# Loop through each point to get the pitch measurements
	for pitchNum from 1 to numberOfPitches

		# get time of pitch measurement from TextGrid
		select TextGrid 'soundName$'
		pitchTime = Get time of point... targetTier pitchNum

		# just in case, be explicit about object selection
		select Pitch 'soundName$'
		# get pitch
		myPitch = Get value at time... pitchTime Hertz Linear

		# print output to Info window
		printline 'soundName$''tab$''pitchTime:3''tab$''myPitch:2'

	endfor
	
	# Clean up
	select Pitch 'soundName$'
	Remove

endfor