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
		'pomodoroTask'
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

{ #category : #initialization }
CrPomodoroWindow >> configurationClass [
	
	^ CrPomodoroConfiguration
]

{ #category : #initialization }
CrPomodoroWindow >> initializePresenters [

	taskLabel := self newLabel label: self taskName.
	timeLabel := self newLabel 
		addStyle: 'pomodoroTime';
		label: self remainingTimeString;
		yourself.
	startButton  := self newButton label: 'Start'.
	breakButton := self newButton label: 'Break'.
	longBreakButton := self newButton label: 'Long Break'.
	stopButton := self newButton label: 'Stop'
]

{ #category : #accessing }
CrPomodoroWindow >> remainingTimeString [

	^ pomodoroTask remainingTime MMSS
]

{ #category : #'accessing model' }
CrPomodoroWindow >> setModelBeforeInitialization: aPomodoroTask [

	pomodoroTask := aPomodoroTask
]

{ #category : #accessing }
CrPomodoroWindow >> taskName [

	^ pomodoroTask name
]

{ #category : #initialization }
CrPomodoroWindow >> title [

	^ 'Pomodoro'
]
