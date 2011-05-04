# another very simple script

# putting constant variables at the top of the script
# makes it easier to modify later
gridName$ = "KF7_pha"
tierNum = 1
intervalNum = 2

clearinfo

select TextGrid 'gridName$'
startTime = Get start point... tierNum intervalNum
endTime = Get end point... 'tierNum' 'intervalNum'

myDuration = endTime - startTime

printline Duration of 'gridName$': 'myDuration'