"
I log to a unqlite database.
"
Class {
	#name : #CrCronoLite,
	#superclass : #CrCrono,
	#category : #'Crono-Model'
}

{ #category : #private }
CrCronoLite >> allTasksBetween: startDate and: endDate [
		
	^ ((CrCronoTask findTasksDoneBetween: startDate and: endDate),
	  (CrTodoTask findTasksDoneBetween: startDate and: endDate))
	sort: #doneDate ascending
]

{ #category : #actions }
CrCronoLite >> log: aString [

	CrCronoTask new 
		notes: aString;
		save
]

{ #category : #actions }
CrCronoLite >> review: daysRange to: aStream [
	| startDate endDate stream |
	
	stream := ZnNewLineWriterStream on: aStream.

	startDate := daysRange fromDate asZTimestamp.
	endDate := (daysRange toDate + 1 day) asDate asZTimestamp.
	((self allTasksBetween: startDate and: endDate)
		groupedBy: [ :each | each doneDate asDate ])
		keysAndValuesDo: [ :day :tasks | 
			stream << day ddmmyyyy; newLine. 
			tasks 
				do: [ :each | each printCronoTimeLogOn: stream ]
				separatedBy: [ stream newLine ].
			stream newLine ]
]
