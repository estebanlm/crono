Class {
	#name : #CrPomodoroTimer,
	#superclass : #Object,
	#instVars : [
		'duration',
		'remainingDuration',
		'service'
	],
	#category : #'Crono-Model-Pomodoro'
}

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

	self initialize.
	self duration: aDuration
]

{ #category : #initialization }
CrPomodoroTimer >> initializeService [

	service := TKTParameterizableService new.
	service name: 'Pomodoro tick service'.
	service stepDelay: 1 second.
	"service onSetUpDo: [ Transcript show: 'File watcher started' ].
	service onTearDownDo: [ Transcript show: 'File watcher finished' ]."
	service step: [ self tick ].
]

{ #category : #testing }
CrPomodoroTimer >> isStopped [

	^ service isRunning not
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

	service start
]

{ #category : #'start-stop' }
CrPomodoroTimer >> stop [

	service stop
]

{ #category : #private }
CrPomodoroTimer >> tick [

	remainingDuration := remainingDuration - 1.
	self notificationCenter notify: CrPomodoroTick
]
