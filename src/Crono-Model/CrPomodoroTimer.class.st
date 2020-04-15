"
I am a timer to be used on pomodoro tasks.
I have a duration and a remainingDuration.
I can be started and stopped.
I ""tick"" each second.
"
Class {
	#name : #CrPomodoroTimer,
	#superclass : #Object,
	#instVars : [
		'duration',
		'remainingDuration',
		'service',
		'tickAction',
		'completedAction'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #'instance creation' }
CrPomodoroTimer class >> new [

	self error: 'Use #newDuration:'
]

{ #category : #'instance creation' }
CrPomodoroTimer class >> newDuration: aDuration [

	^ self basicNew
		initializeDuration: aDuration;
		yourself
]

{ #category : #private }
CrPomodoroTimer >> duration: aDuration [

	duration := aDuration.
	remainingDuration := duration.
]

{ #category : #initialization }
CrPomodoroTimer >> initialize [

	super initialize.
	self initializeService
]

{ #category : #initialization }
CrPomodoroTimer >> initializeDuration: aDuration [

	self duration: aDuration.	
	self initialize.

]

{ #category : #initialization }
CrPomodoroTimer >> initializeService [

	service := TKTParameterizableService new
		name: ('Pomodoro: {1}' format: { duration mmss }) ;
		stepDelay: 1 second;
		step: [ self tick ];
		yourself
]

{ #category : #testing }
CrPomodoroTimer >> isStopped [

	^ service isRunning not
]

{ #category : #events }
CrPomodoroTimer >> onCompleted: aBlock [

	completedAction := aBlock
]

{ #category : #events }
CrPomodoroTimer >> onTick: aBlock [

	tickAction := aBlock
]

{ #category : #accessing }
CrPomodoroTimer >> remainingTime [

	^ remainingDuration
]

{ #category : #initialization }
CrPomodoroTimer >> reset [

	remainingDuration := duration 
]

{ #category : #'start-stop' }
CrPomodoroTimer >> start [

	self reset.
	service start
]

{ #category : #'start-stop' }
CrPomodoroTimer >> stop [

	self reset.
	service isRunning 
		ifTrue: [ service stop ]
]

{ #category : #private }
CrPomodoroTimer >> tick [

	remainingDuration := remainingDuration - 1 second.
	tickAction ifNotNil: [ 
		tickAction cull: self ].
	
	remainingDuration = 0 asDuration ifTrue: [ 
		completedAction ifNotNil: [ 
			completedAction cull: self ] ]
]
