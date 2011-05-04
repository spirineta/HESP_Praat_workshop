# This script gets a pitch value
# The sound should have a TextGrid with a point tier that 
# specifies where the pitch measurements should be taken.

soundName$ = "speech_maryanna_decl"
targetTier = 3
pointNum = 1

clearinfo

# get time of pitch measurement from TextGrid
select TextGrid 'soundName$'
pitchTime = Get time of point... targetTier pointNum

# create Pitch object for getting the measurement
select Sound 'soundName$'
To Pitch... 0 75 400
# just in case, be explicit about object selection
select Pitch 'soundName$'
# get pitch
myPitch = Get value at time... pitchTime Hertz Linear

printline Pitch at 'pitchTime:3' in 'soundName$': 'myPitch:2' Hz
