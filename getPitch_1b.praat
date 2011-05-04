# This script gets a pitch value from a series of points in a sound
# The sound should have a TextGrid with a point tier that 
# specifies where the pitch measurements should be taken.

soundName$ = "speech_maryanna_incred"
targetTier = 3
minPitch = 75
maxPitch = 400

clearinfo

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
	
	# print output to Info windo
	printline Pitch at 'pitchTime:3' in 'soundName$': 'myPitch:2' Hz

endfor

