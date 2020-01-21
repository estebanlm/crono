Class {
	#name : #CrTodoTask,
	#superclass : #Object,
	#instVars : [
		'owner',
		'name',
		'notes',
		'startDate',
		'doneDate',
		'tags',
		'focused',
		'archived'
	],
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTask class >> findTasksDoneBetween: start and: end [
	| startTS endTS | 

	startTS := start asZTimestamp.
	endTS := end asZTimestamp.
	^ self selectMany: [ :each | 
		"Do not use the helper to not use the DNU mechanism (to increase query speed)"
		(each at: 'doneDate') 
			ifNotNil: [ :date | date asZTimestamp between: startTS and: endTS ]
			ifNil: [ false ] ]
]

{ #category : #testing }
CrTodoTask class >> isVoyageRoot [

	^ true
]

{ #category : #'ston-core' }
CrTodoTask class >> stonName [

	^ 'Task'
]

{ #category : #persistence }
CrTodoTask class >> voyageCollectionName [

	^ 'tasks'
]

{ #category : #persistence }
CrTodoTask class >> voyageDoneDate [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'doneDate';
		accessor: (MAPluggableAccessor 
			read: [ :aTask | aTask doneDate ifNotNil: #asString ]
			write: [ :aTask :date | 
				date ifNotNil: [ aTask setDoneDate: (ZTimestamp fromString: date) ] ]);
		yourself
]

{ #category : #persistence }
CrTodoTask class >> voyageRepository [

	^ CrModelApplication current repository
]

{ #category : #persistence }
CrTodoTask class >> voyageStartDate [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'startDate';
		accessor: (MAPluggableAccessor 
			read: [ :aTask | aTask startDate ifNotNil: #asString ]
			write: [ :aTask :date | 
				date ifNotNil: [ aTask setStartDate: (ZTimestamp fromString: date) ] ]);
		yourself
]

{ #category : #persistence }
CrTodoTask class >> voyageTags [
	<voyageDescription>
	
	^ VOToManyDescription new 
		attributeName: 'tags';
		kindCollection: Array;
		yourself
]

{ #category : #actions }
CrTodoTask >> archive [

	self isArchived ifTrue: [ ^ self ].
	self archived: true.
	self focus: false.
	self save
]

{ #category : #actions }
CrTodoTask >> archiveIfDone [

	self archiveIfDoneAfterDays: 0
	
]

{ #category : #actions }
CrTodoTask >> archiveIfDoneAfterDays: daysNumber [

	self isArchived ifTrue: [ ^ self ].
	self isDone ifFalse: [ ^ self ].
	(self doneDate < (ZTimestamp now - daysNumber days)) ifFalse: [ ^ self ].
	
	self archived: true.
	self focus: false.
	self save
]

{ #category : #accessing }
CrTodoTask >> archived: aBoolean [

	archived := aBoolean
]

{ #category : #actions }
CrTodoTask >> changeFocusTo: aBoolean [

	self focus: aBoolean.
	self save
]

{ #category : #actions }
CrTodoTask >> changeStatusTo: aBoolean [

	self done: aBoolean.
	self save
]

{ #category : #private }
CrTodoTask >> collectTagsOn: aString [

	^ #()
]

{ #category : #accessing }
CrTodoTask >> done: aBoolean [

	doneDate := aBoolean 
		ifTrue: [ ZTimestamp now ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
CrTodoTask >> doneDate [
	^ doneDate
]

{ #category : #accessing }
CrTodoTask >> focus: aBoolean [

	focused := aBoolean
]

{ #category : #accessing }
CrTodoTask >> fullName [

	^ String streamContents: [ :stream |
		stream << self owner name << ': ' << self name ]
]

{ #category : #testing }
CrTodoTask >> hasNotes [

	^ self notes isEmptyOrNil not
]

{ #category : #initialization }
CrTodoTask >> initialize [

	super initialize. 
	startDate := ZTimestamp now.
	focused := false.
	archived := false
]

{ #category : #testing }
CrTodoTask >> isArchived [

	^ archived or: [ self owner isArchived ]
]

{ #category : #testing }
CrTodoTask >> isDone [

	^ doneDate notNil
]

{ #category : #accessing }
CrTodoTask >> isFocused [

	^ focused
]

{ #category : #testing }
CrTodoTask >> isVisible [

	^ self isArchived not 
		and: [ self isDone not or: [ self isStillShown: self doneDate ] ]
]

{ #category : #accessing }
CrTodoTask >> listName [

	^ self owner name
]

{ #category : #accessing }
CrTodoTask >> name [
	^ name
]

{ #category : #accessing }
CrTodoTask >> name: aString [

	name := aString
]

{ #category : #accessing }
CrTodoTask >> notes [
	^ notes
]

{ #category : #accessing }
CrTodoTask >> notes: aString [

	notes := aString
]

{ #category : #accessing }
CrTodoTask >> owner [
	
	^ owner
]

{ #category : #accessing }
CrTodoTask >> owner: aTodoList [

	owner := aTodoList
]

{ #category : #printing }
CrTodoTask >> printChangeLogLines: aString on: stream [

	(aString withNoLineLongerThan: 96) lines 
		do: [ :each | stream << '    ' << each ]
		separatedBy: [ stream newLine ].

]

{ #category : #printing }
CrTodoTask >> printChangeLogOn: stream [ 
	
	self printChangeLogLines: ('* ', self fullName) on: stream.
	self notes isEmptyOrNil ifTrue: [ ^ self ].  
	stream newLine.
	self printChangeLogLines: self notes on: stream
]

{ #category : #printing }
CrTodoTask >> printCronoTimeLines: aString time: aBoolean on: stream [
	| time separator |
	
	separator := String new: 6 withAll: Character space.
	time :=  (aBoolean and: [ self doneDate notNil ]) 
		ifTrue: [ self doneDate asTime logPrintTime, ' ' ]
		ifFalse: [ separator ].	
			
	(aString withNoLineLongerThan: 94) lines 
		do: [ :each | 
			stream << time << each.
			time := separator ]
		separatedBy: [ 
			stream newLine ]
]

{ #category : #printing }
CrTodoTask >> printCronoTimeLogOn: stream [ 

	self printCronoTimeLines: self fullName time: true on: stream.
	self notes isEmptyOrNil ifTrue: [ ^ self ].  

	stream newLine.
	self printCronoTimeLines: self notes time: false on: stream
]

{ #category : #printing }
CrTodoTask >> printOn: stream [

	super printOn: stream.
	stream << '(' << self name << ')'
]

{ #category : #persistence }
CrTodoTask >> save [ 

	self updateTags.
	super save
]

{ #category : #private }
CrTodoTask >> setDoneDate: aDateAndTime [
	
	doneDate := aDateAndTime
]

{ #category : #private }
CrTodoTask >> setStartDate: aDateAndTime [
	
	startDate := aDateAndTime
]

{ #category : #accessing }
CrTodoTask >> shortName [

	"maybe truncateWithElipsisTo: ?"
	^ self name contractTo: 20
]

{ #category : #accessing }
CrTodoTask >> startDate [

	^ startDate
]

{ #category : #accessing }
CrTodoTask >> takeMemento [

	^ self class allSlots 
		collect: [ :each | (self readSlot: each) copy ]
		as: Array
]

{ #category : #actions }
CrTodoTask >> toggleFocus [
	
	self changeFocusTo: self isFocused not
]

{ #category : #actions }
CrTodoTask >> unarchive [

	self isArchived ifFalse: [ ^ self ].
	self archived: false.
	self save
]

{ #category : #private }
CrTodoTask >> updateTags [
	
	tags := ((self collectTagsOn: self name), (self collectTagsOn: self notes)) removeDuplicates

]
