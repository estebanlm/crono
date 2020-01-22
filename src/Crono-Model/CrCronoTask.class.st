Class {
	#name : #CrCronoTask,
	#superclass : #Object,
	#instVars : [
		'doneDate',
		'notes',
		'tags'
	],
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrCronoTask class >> findTasksDoneBetween: start and: end [
	| startTS endTS | 

	startTS := start asZTimestamp.
	endTS := end asZTimestamp.
	^ self selectMany: [ :each | 
		"Do not use the helper to not use the DNU mechanism (to increase query speed)"
		(each at: 'doneDate') asZTimestamp 
			between: startTS
			and: endTS ]
]

{ #category : #testing }
CrCronoTask class >> isVoyageRoot [

	^ true
]

{ #category : #persistence }
CrCronoTask class >> voyageCollectionName [
	"Sending to a per-year collection to optimise storage. 
	 Maybe unnecesary."
	
	^ 'crono-tasks-{1}' format: { Year current year }
]

{ #category : #persistence }
CrCronoTask class >> voyageDoneDate [
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
CrCronoTask class >> voyageRepository [

	^ CrModelApplication current cronoRepository
]

{ #category : #persistence }
CrCronoTask class >> voyageTags [
	<voyageDescription>
	
	^ VOToManyDescription new 
		attributeName: 'tags';
		kindCollection: Array;
		yourself
]

{ #category : #private }
CrCronoTask >> collectTagsOn: aString [

	^ CrTagCollector collectTagsOn: aString
]

{ #category : #accessing }
CrCronoTask >> doneDate [

	^ doneDate
]

{ #category : #testing }
CrCronoTask >> hasNotes [

	^ self notes isEmptyOrNil not
]

{ #category : #testing }
CrCronoTask >> isDone [

	^ doneDate notNil
]

{ #category : #accessing }
CrCronoTask >> notes [

	^ notes
]

{ #category : #accessing }
CrCronoTask >> notes: aString [

	notes := aString
]

{ #category : #printing }
CrCronoTask >> printChangeLogOn: stream [ 
	
	(('* ', self notes) withNoLineLongerThan: 96) lines 
		do: [ :each | stream << '    ' << each ]
		separatedBy: [ stream cr ]
]

{ #category : #printing }
CrCronoTask >> printCronoTimeLogOn: stream [ 
	| time separator |
	
	separator := String new: 6 withAll: Character space.
	time :=  self doneDate 
		ifNotNil: [ :ts | ts asTime logPrintTime, ' ' ]
		ifNil: [ separator ].
		
	(self notes withNoLineLongerThan: 94) lines 
		do: [ :each | 
			stream << time << each.
			time := separator ]
		separatedBy: [ 
			stream cr ]
]

{ #category : #printing }
CrCronoTask >> printOn: stream [ 
	
	stream << self notes
]

{ #category : #persistence }
CrCronoTask >> save [ 

	self setDoneDate: ZTimestamp now.
	self updateTags.
	super save
]

{ #category : #private }
CrCronoTask >> setDoneDate: aZTimestamp [
	
	doneDate := aZTimestamp
]

{ #category : #accessing }
CrCronoTask >> tags [

	^ tags
]

{ #category : #private }
CrCronoTask >> updateTags [
	
	tags := (self collectTagsOn: self notes) asSet asArray
]
