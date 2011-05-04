# Superimposing noise

form Superimposing noise
	sentence File_with_target_SNRs PATH\noise_ratios.txt
	sentence Where_to_find_target_sounds PATH
	sentence Where_to_save_output_files PATH
	choice Targets_saved_as: 1
		button .wav
		button .flac
	choice Outputs_saved_as: 1
		button .wav
		button .flac
	sentence Noise_formula randomGauss(0, 0.1)
	positive Target_tier 1
	positive Target_interval 2
endform

subjectColumn$ = "subject"
wordColumn$ = "target"
ratioColumn$ = "ratio"

# Read in table of ratios
Read Table from tab-separated file... 'file_with_target_SNRs$'
ratioTable = selected ("Table")

# Loop over rows in the table
nRows = Get number of rows

for currentItem to nRows
	# get values for item
	select ratioTable
	subject$ = Get value... 'currentItem' 'subjectColumn$'
	word$ = Get value... 'currentItem' 'wordColumn$'
	ratio = Get value... 'currentItem' 'ratioColumn$'

	# get name of file to read
	soundName$ = subject$ + "_" + word$

	# Load files
	Read from file... 'where_to_find_target_sounds$'\'soundName$''targets_saved_as$'
	currentTarget = selected ("Sound")
	Scale peak... 0.99
	Read from file... 'where_to_find_target_sounds$'\'soundName$'.TextGrid
	currentGrid = selected ("TextGrid")

	# Create noise of correct duration
	select currentTarget
	currentDuration = Get total duration
	targetSampleRate = Get sampling frequency
	Create Sound from formula... noise 1 0.0 'currentDuration' 'targetSampleRate' 'noise_formula$'
	currentNoise = selected ("Sound")

	# measure RMS of noise and target vowel
	select currentNoise
	noiseRMS = Get root-mean-square... 0 0
	select currentGrid
	timeStart = Get start point... 'target_tier' 'target_interval'
	timeEnd = Get end point... 'target_tier' 'target_interval'
	select currentTarget
	targetRMS = Get root-mean-square... 'timeStart' 'timeEnd'

	# multiply noise to get target ratio
	noiseFactor = targetRMS/noiseRMS/sqrt(ratio)
	select currentNoise
	Multiply... 'noiseFactor'

	# combine
	select currentTarget
	plus currentNoise
	Combine to stereo
	stereo = selected ("Sound")
	Convert to mono
	output = selected ("Sound")

	# write to file
	outName$ = soundName$ + "_withnoise" + outputs_saved_as$
	select output
	if outputs_saved_as = 1
		Write to WAV file... 'where_to_save_output_files$'\'outName$'
	elsif outputs_saved_as = 2
		Write to FLAC file... 'where_to_save_output_files$'\'outName$'
	endif
	
	# clean up
	select currentTarget
	plus currentGrid
	plus currentNoise
	plus stereo
	plus output
	#Remove

endfor

# Clean up 
select ratioTable
#Remove