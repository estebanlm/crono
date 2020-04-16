"
I am a pomodoro task.
I have a start date and a completion status. 

For integrity, I should persist just completed tasks.
"
Class {
	#name : #CrPomodoroTask,
	#superclass : #Object,
	#instVars : [
		'ownerTask',
		'startDate',
		'completed'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #'instance creation' }
CrPomodoroTask class >> newTask: aTask [ 

	^ self new 
		ownerTask: aTask;
		yourself
]

{ #category : #persistence }
CrPomodoroTask class >> voyageOwnerTask [
	<voyageDescription>
	
	^ VOTransientDescription new 
		attributeName: 'ownerTask';
		yourself
]

{ #category : #persistence }
CrPomodoroTask class >> voyageStartDate [
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
CrPomodoroTask class >> voyageTick [
	<voyageDescription>
	
	^ VOTransientDescription new 
		attributeName: 'timer';
		yourself
]

{ #category : #accessing }
CrPomodoroTask >> beCompleted [

	completed := true
]

{ #category : #private }
CrPomodoroTask >> completed [ 

	self beCompleted.
	self ownerTask addPomodoroTask: self copy
]

{ #category : #initialization }
CrPomodoroTask >> initialize [

	super initialize.
	completed := false
]

{ #category : #testing }
CrPomodoroTask >> isCompleted [ 

	^ completed
]

{ #category : #accessing }
CrPomodoroTask >> name [

	^ self ownerTask pomodoroName
]

{ #category : #'instance creation' }
CrPomodoroTask >> newTimer [ 
	| timer |
	
	timer := CrPomodoroTimer newDuration: self settings pomodoroDuration.
	timer 
		onStarted: [ self started ];
		onCompleted: [ self completed ].
	
	^ timer
]

{ #category : #accessing }
CrPomodoroTask >> ownerTask [

	^ ownerTask
]

{ #category : #accessing }
CrPomodoroTask >> ownerTask: aTask [

	ownerTask := aTask
]

{ #category : #private }
CrPomodoroTask >> setStartDate: aTimestamp [

	startDate := aTimestamp
]

{ #category : #private }
CrPomodoroTask >> setStartDateFromString: aString [

	self setStartDate: (aString ifNotNil: [ ZTimestamp fromString: aString ])
]

{ #category : #initialization }
CrPomodoroTask >> settings [

	^ CrPomodoroConfiguration readFromFileSystem
]

{ #category : #accessing }
CrPomodoroTask >> startDate [

	^ startDate
]

{ #category : #private }
CrPomodoroTask >> started [

	self setStartDate: ZTimestamp now
]
