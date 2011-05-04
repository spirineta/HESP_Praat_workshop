# DupouxKouider_2
#################
# by: Scott Jackson
# last modified: 4\8\10
#####################
# This script takes a bunch of sounds and a tab-delimited textfile as input, and 
# produces stimuli along the lines of Dupoux & Kouider (2005)'s Expt 1
# The text file needs the following columns:
#	Target: the sound file name (without .wav extension) for the target
#	Prime: file name (w\o extension) for the prime
#	FwdMask: file name for the forward mask (the very beginning sound)
#	BkwdMask1 through BkwdMask4: file names for the backward masks, in the 
#		order you want them to be played (i.e., BkwdMask1 is the sound
#		that is concurrent with the beginning of the Target, BkwdMask2
#		follows that one, and so on).
#	ItemName: the name that you want the resulting sound file to be called
#		(again without extension)
#	DurationRatio: the ratio that you want the non-targets compressed by in
#		the time domain.  E.g., if you want all the masks & prime for a
#		given item to be 35% of their normal length, this value should
#		be 0.35 for this item.
#
# The only difference between this version and the "DupouxKouider" script (from
# 4\6\09) is that the former requires you to have all your sound files pre-loaded
# in the Praat objects window, whereas this script loads and removes each file as
# needed.  This is handy if you have too many files to fit into the objects window
# at once (i.e. > 1000).
#
# You specify the location & name of the item file AND the location of all the sound 
# files in the beginning dialog box.

clearinfo

form Item file path and name
	word Filename C:YOURPATH\items.txt
	word Sound_file_folder C:YOURPATHFORSOUNDS
	integer Sample_rate_of_stimuli 22050
	positive Min_pitch_for_resynthesis 75
	positive Max_pitch_for_resynthesis 600	
endform

# open item file as a Table and index it
Read Table from tab-separated file... 'filename$'
itemTable = selected ("Table")

# Get number of rows in the item file
nRows = Get number of rows

# Start main loop
for currentItem to nRows
	# Make copies and index each file
	# As you go, attentuate and shorten EACH file (except Target)
	select itemTable
	targetName$ = Get value... 'currentItem' Target
	primeName$ = Get value... 'currentItem' Prime
	fwdMaskName$ = Get value... 'currentItem' FwdMask
	bkwdMask1Name$ = Get value... 'currentItem' BkwdMask1
	bkwdMask2Name$ = Get value... 'currentItem' BkwdMask2
	bkwdMask3Name$ = Get value... 'currentItem' BkwdMask3
	bkwdMask4Name$ = Get value... 'currentItem' BkwdMask4
	bkwdMask5Name$ = Get value... 'currentItem' BkwdMask5
	itemName$ = Get value... 'currentItem' ItemName
	newDurationRatio = Get value... 'currentItem' DurationRatio
	
	#Read from file... 'sound_file_folder$'\'targetName$'.wav
	Read from file... 'sound_file_folder$''targetName$'.wav
	targetPiece = selected ("Sound")
	# select Sound 'targetName$'
	Copy... target
	currentTarget = selected ("Sound")

	#Read from file... 'sound_file_folder$'\'fwdMaskName$'.wav
	Read from file... 'sound_file_folder$''fwdMaskName$'.wav
	fwdMaskPiece = selected ("Sound")
	# select Sound 'fwdMaskName$'
	Copy... fwdmask
	tempFwdMask = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... fwdmask
	currentFwdMask = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempFwdMask
	Remove

	#Read from file... 'sound_file_folder$'\'primeName$'.wav
	Read from file... 'sound_file_folder$''primeName$'.wav
	primePiece = selected ("Sound")
	# select Sound 'primeName$'
	Copy... prime
	tempPrime = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... prime
	currentPrime = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempPrime
	Remove

	#Read from file... 'sound_file_folder$'\'bkwdMask5Name$'.wav
	Read from file... 'sound_file_folder$''bkwdMask5Name$'.wav
	bkwdMask5Piece = selected ("Sound")
	# select Sound 'bkwdMask5Name$'
	Copy... bkwdmask5
	tempBkwdMask5 = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... bkwdmask5
	currentBkwdMask5 = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempBkwdMask5
	Remove

	#Read from file... 'sound_file_folder$'\'bkwdMask4Name$'.wav
	Read from file... 'sound_file_folder$''bkwdMask4Name$'.wav
	bkwdMask4Piece = selected ("Sound")
	# select Sound 'bkwdMask4Name$'
	Copy... bkwdmask4
	tempBkwdMask4 = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... bkwdmask4
	currentBkwdMask4 = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempBkwdMask4
	Remove

	#Read from file... 'sound_file_folder$'\'bkwdMask3Name$'.wav
	Read from file... 'sound_file_folder$''bkwdMask3Name$'.wav
	bkwdMask3Piece = selected ("Sound")
	# select Sound 'bkwdMask3Name$'
	Copy... bkwdmask3
	tempBkwdMask3 = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... bkwdmask3
	currentBkwdMask3 = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempBkwdMask3
	Remove

	#Read from file... 'sound_file_folder$'\'bkwdMask2Name$'.wav
	Read from file... 'sound_file_folder$''bkwdMask2Name$'.wav
	bkwdMask2Piece = selected ("Sound")
	# select Sound 'bkwdMask2Name$'
	Copy... bkwdmask2
	tempBkwdMask2 = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... bkwdmask2
	currentBkwdMask2 = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempBkwdMask2
	Remove

	#Read from file... 'sound_file_folder$'\'bkwdMask1Name$'.wav
	Read from file... 'sound_file_folder$''bkwdMask1Name$'.wav
	bkwdMask1Piece = selected ("Sound")
	# select Sound 'bkwdMask1Name$'
	Copy... bkwdmask1
	tempBkwdMask1 = selected ("Sound")
	startdB = Get intensity (dB)
	quietdB = startdB - 15
	Scale intensity... 'quietdB'
	# Create manipulation and index it
	To Manipulation... 0.01 'min_pitch_for_resynthesis' 'max_pitch_for_resynthesis'
	manipulationIdent = selected ("Manipulation")	

	# Extract duration tier and index it
	Extract duration tier
	durationtierIdent = selected ("DurationTier")

	# Add new duration point at specified ratio
	select durationtierIdent
	Add point... 0.01 'newDurationRatio'

	# Do resynthesis
	select durationtierIdent
	plus manipulationIdent
	Replace duration tier
	select manipulationIdent
	Get resynthesis (overlap-add)

	# Rename new sound and index it
	Rename... bkwdmask1
	currentBkwdMask1 = selected ("Sound")
	
	# Clean up (remove manipulation and duration tier objects)
	select durationtierIdent
	plus manipulationIdent
	plus tempBkwdMask1
	Remove

	# Reverse forward mask
	select 'currentFwdMask'
	Reverse

	# Concatenate forward mask with prime
	select 'currentFwdMask'
	plus 'currentPrime'
	Concatenate
	Rename... Part1
	part1 = selected ("Sound")

	# Concatenate & reverse 4 masks -> backward mask
	select currentBkwdMask5
	plus currentBkwdMask4
	plus currentBkwdMask3
	plus currentBkwdMask2
	plus currentBkwdMask1

	Concatenate

	Rename... BkwdMaskAll
	Reverse
	bkwdMaskAll = selected ("Sound")
	
	# Add silence on the end of target to match length of backward mask
	select 'bkwdMaskAll'
	bkwdMaskLength = Get total duration

	select 'currentTarget'
	targetLength = Get total duration
	addLength = bkwdMaskLength - targetLength
	
	if addLength > 0
		Create Sound from formula... silence Mono 0 'addLength' 'sample_rate_of_stimuli' 0
		currentSilence = selected ("Sound")	
		select 'currentTarget'
		plus 'currentSilence'
		Concatenate
		Rename... newtarget
		newTarget = selected ("Sound")
		select 'bkwdMaskAll'
		Copy... NewBkwdMaskAll
		newBkwdMaskAll = selected ("Sound")
	else
		addLength = targetLength - bkwdMaskLength
		printline WARNING! mask for the target filename 'targetName$', item name 'itemName$' is 'addLength' seconds too short!
		printline The item will be created, but the target will not be completely masked.
		 
		Create Sound from formula... silence Mono 0 'addLength' 'sample_rate_of_stimuli' 0
		currentSilence = selected ("Sound")	
		select 'bkwdMaskAll'
		plus 'currentSilence'
		Concatenate
		Rename... NewBkwdMaskAll
		newBkwdMaskAll = selected ("Sound")
		select 'currentTarget'
		Copy... newtarget
		newTarget = selected ("Sound")
		
		newTargetLength = Get total duration
		select 'newBkwdMaskAll'
		newMaskLength = Get total duration
		
		printline The new mask length (with silence) equals: 'newMaskLength'
		printline The new target length (which should be the same) equals: 'newTargetLength'
		
		
	endif
	
	# Combine target and backward mask as stereo
	select 'newTarget'
	plus 'newBkwdMaskAll'
	Combine to stereo
	Rename... stereoPart2
	stereoPart = selected ("Sound")
	
	# Convert stereo file to mono
	Convert to mono
	Rename... Part2
	part2 = selected ("Sound")

	# Concatenate two big parts
	select 'part1'
	plus 'part2'
	Concatenate
	Rename... 'itemName$'
	

	# Clean up
	select currentTarget
	plus currentPrime
	plus currentFwdMask
	plus currentBkwdMask1
	plus currentBkwdMask2
	plus currentBkwdMask3
	plus currentBkwdMask4
	plus currentBkwdMask5
	plus bkwdMaskAll
	plus currentSilence
	plus newTarget
	plus stereoPart
	plus part1
	plus part2
	# the following are the new clean-up steps
	plus targetPiece
	plus fwdMaskPiece
	plus primePiece
	plus bkwdMask5Piece
	plus bkwdMask4Piece
	plus bkwdMask3Piece
	plus bkwdMask2Piece
	plus bkwdMask1Piece
	Remove



	

endfor

exit
