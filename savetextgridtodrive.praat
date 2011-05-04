# This script saves all TextGrid objects in the objects list to .TextGrid files,
# named the same way they are in the objects list.
# Copyright 9.28.2008 Charles Chang

# specify where to save the TextGrids
form Where do you want to save the files?
	sentence Output_Directory InsertDirectoryHere/
endform

# select all of the objects in the list
select all

# get the count of TextGrid objects in the objects list
numSelected = numberOfSelected("TextGrid")

# cycle through all the TextGrids, saving each to a .TextGrid file
for i from 1 to numSelected
	current_textgrid = selected("TextGrid", i)
	name$ = selected$("TextGrid", i)
	select current_textgrid
	Write to text file... 'output_Directory$''name$'.TextGrid
	select all
endfor