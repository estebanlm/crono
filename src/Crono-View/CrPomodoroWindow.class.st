"
I am a pomodoro window.
In the system, there can be only one active at a time (this will be handled in the main window)
"
Class {
	#name : #CrPomodoroWindow,
	#superclass : #CrPresenter,
	#instVars : [
		'taskLabel',
		'timeLabel',
		'startButton',
		'breakButton',
		'longBreakButton',
		'stopButton',
		'pomodoroTask',
		'currentTimer',
		'settings'
	],
	#category : #'Crono-View-Pomodoro'
}

{ #category : #specs }
CrPomodoroWindow class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add:(SpBoxLayout newHorizontal 
				hAlignCenter;
				add: #timeLabel;
				yourself);
		add: (SpBoxLayout newHorizontal 
				hAlignCenter;
				vAlignCenter;
				add: #taskLabel;
				yourself)
			expand: false;
		add: (SpBoxLayout newHorizontal 
				hAlignCenter;
				spacing: 5;
				add: #startButton expand: false;
				add: #breakButton expand: false;
				add: #longBreakButton expand: false;
				add: #stopButton expand: false;
				yourself)
			expand: false;
		yourself
]

{ #category : #private }
CrPomodoroWindow >> basicStop [

	currentTimer ifNotNil: [ currentTimer stop ]
]

{ #category : #actions }
CrPomodoroWindow >> break [

	self basicStop.
	currentTimer := CrPomodoroTimer newDuration: self settings breakDuration.
	currentTimer onTick: [ self updatePresenter ].
	currentTimer start
]

{ #category : #initialization }
CrPomodoroWindow >> configurationClass [
	
	^ CrPomodoroConfiguration
]

{ #category : #accessing }
CrPomodoroWindow >> currentTimer [

	^ currentTimer ifNil: [ currentTimer := pomodoroTask newTimer ]
]

{ #category : #initialization }
CrPomodoroWindow >> initializePresenters [

	taskLabel := self newLabel label: self taskName.
	timeLabel := self newLabel 
		addStyle: 'pomodoroTime';
		label: self remainingTimeString;
		yourself.
	startButton  := self newButton 
		label: self settings pomodoroDuration mmss;
		action: [ self start ];
		yourself.
	breakButton := self newButton 
		label: self settings breakDuration mmss;
		action: [ self break ].
	longBreakButton := self newButton 
		label: self settings longBreakDuration mmss;
		action: [ self longBreak ].
	stopButton := self newButton 
		label: 'Stop';
		action: [ self stop ]
]

{ #category : #actions }
CrPomodoroWindow >> longBreak [

	self basicStop.
	currentTimer := CrPomodoroTimer newDuration: self settings longBreakDuration.
	currentTimer onTick: [ self updatePresenter ].
	currentTimer start
]

{ #category : #accessing }
CrPomodoroWindow >> remainingTime [

	^ self currentTimer remainingTime
]

{ #category : #accessing }
CrPomodoroWindow >> remainingTimeString [

	^ self remainingTime mmss
]

{ #category : #'accessing model' }
CrPomodoroWindow >> setModelBeforeInitialization: aPomodoroTask [

	pomodoroTask := aPomodoroTask
]

{ #category : #initialization }
CrPomodoroWindow >> settings [ 

	^ settings ifNil: [ 
		settings := CrPomodoroConfiguration readFromFileSystem ]
]

{ #category : #actions }
CrPomodoroWindow >> start [

	self basicStop.
	currentTimer := pomodoroTask newTimer.
	currentTimer onTick: [ self updatePresenter ].
	currentTimer start
]

{ #category : #actions }
CrPomodoroWindow >> stop [

	self basicStop.
	currentTimer := nil.
	self updatePresenter
]

{ #category : #accessing }
CrPomodoroWindow >> taskName [

	^ pomodoroTask name
]

{ #category : #initialization }
CrPomodoroWindow >> title [

	^ 'Pomodoro'
]

{ #category : #initialization }
CrPomodoroWindow >> updatePresenter [

	timeLabel label: self remainingTimeString.
	self remainingTime < 0 asDuration
		ifTrue: [ timeLabel addStyle: 'pomodoroSurpassedTime' ]
		ifFalse: [ timeLabel removeStyle: 'pomodoroSurpassedTime' ]
]
