"
I am a ""crono task"": a task that is independent of a todo list.
It happens often that you work on a task you forgot to add to the list (or simply you do not consider it worth of being there), but you still want to register that activity. 
Well, I am used for that :)
"
Class {
	#name : #CrCronoTask,
	#superclass : #Object,
	#traits : 'CrTPomodoroContainer',
	#classTraits : 'CrTPomodoroContainer classTrait',
	#instVars : [
		'doneDate',
		'notes',
		'tags'
	],
	#category : #'Crono-Model-Crono'
}

{ #category : #accessing }
CrCronoTask class >> findTasksDoneBetween: start and: end [
	| startTS endTS |  

	startTS := start asZTimestamp printString.
	endTS := end asZTimestamp printString.
	^ self selectMany: [ :each | (each doneDate >= startTS) & (each doneDate <= endTS) ]
]

{ #category : #testing }
CrCronoTask class >> isVoyageRoot [

	^ true
]

{ #category : #persistence }
CrCronoTask class >> voyageCollectionName [
	"Sending to a per-year collection to optimise storage. 
	 Maybe unnecesary."
	
	^ 'crono-tasks' format: { Year current year }
]

{ #category : #persistence }
CrCronoTask class >> voyageDoneDate [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'doneDate';
		accessor: (MAPluggableAccessor 
			read: [ :aTask | aTask doneDate ifNotNil: #asString ]
			write: [ :aTask :date | aTask setDoneDateFromString: date ]);
		yourself
]

{ #category : #persistence }
CrCronoTask class >> voyageRepository [

	^ CrModelApplication current repository
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

{ #category : #accessing }
CrCronoTask >> pomodoroName [

	^ self notes lines first
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

{ #category : #private }
CrCronoTask >> setDoneDateFromString: aString [ 
	
	aString isString ifFalse: [ ^ self ].
	self setDoneDate: (aString ifNotNil: [ ZTimestamp fromString: aString ]).
	
]

{ #category : #accessing }
CrCronoTask >> tags [

	^ tags
]

{ #category : #private }
CrCronoTask >> updateTags [
	
	tags := (self collectTagsOn: self notes) asSet asArray
]
