"
I log to a text file.
"
Class {
	#name : #CrCronoFile,
	#superclass : #CrCrono,
	#category : #'Crono-Model'
}

{ #category : #actions }
CrCronoFile >> log: aString [
	| nl |

	nl := OSPlatform current lineEnding.
	self todayReference writeStreamDo: [ :stream | | lines |
		stream setToEnd.
		stream << Time now logPrintTime << ' '.
		lines := (aString withNoLineLongerThan: 94) lines.
		stream << lines first << nl.
		lines allButFirstDo: [ :each | stream << '      ' << each << nl ] ].
	
	self stdout << 'You work, therefore you are.'; newLine
]

{ #category : #accessing }
CrCronoFile >> logReference [

	^ CrCronoConfiguration readFromFileSystem logReference	
]

{ #category : #accessing }
CrCronoFile >> printTodayReference [

	self stdout << self todayReference fullName; newLine
]

{ #category : #accessing }
CrCronoFile >> referenceOfDay: aDate [

	^ (self logReference / aDate yyyymmdd) withExtension: 'txt' 
]

{ #category : #accessing }
CrCronoFile >> review: daysRange to: stream [

	daysRange days 
		do: [ :each | | dayRef |
			stream << each ddmmyyyy; newLine. 
			dayRef := self referenceOfDay: each.
			stream << (dayRef exists 
				ifTrue: [ dayRef contents ]
				ifFalse: [ 'No records' ]) ]
		separatedBy: [ 
			stream newLine ]
]

{ #category : #accessing }
CrCronoFile >> todayReference [

	^ self referenceOfDay: Date today
]
