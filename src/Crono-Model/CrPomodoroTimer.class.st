"
I am a timer to be used on pomodoro tasks.
I have a duration and a remainingDuration.
I can be started and stopped.
I ""tick"" each second.
"
Class {
	#name : #CrPomodoroTimer,
	#superclass : #Object,
	#traits : 'SpTObservable',
	#classTraits : 'SpTObservable classTrait',
	#instVars : [
		'#remainingDuration => SpObservableSlot',
		'#completed => SpObservableSlot',
		'#duration',
		'#service'
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
	
	self class initializeSlots: self.
	super initialize.
	completed := false
]

{ #category : #initialization }
CrPomodoroTimer >> initializeDuration: aDuration [

	self initialize.
	self duration: aDuration.
	self initializeService
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
	
	self 
		property: #completed 
		whenChangedDo: [ :aBoolean | aBoolean ifTrue: aBlock ]
]

{ #category : #events }
CrPomodoroTimer >> onStarted: aBlock [
	
	self 
		property: #completed 
		whenChangedDo: [ :aBoolean | aBoolean ifFalse: aBlock ]
]

{ #category : #events }
CrPomodoroTimer >> onTick: aBlock [

	self 
		property: #remainingDuration 
		whenChangedDo: aBlock
]

{ #category : #accessing }
CrPomodoroTimer >> remainingTime [

	^ remainingDuration
]

{ #category : #initialization }
CrPomodoroTimer >> reset [

	remainingDuration := duration.
	completed := false	
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
	remainingDuration = 0 asDuration 
		ifTrue: [ completed := true ]
]
