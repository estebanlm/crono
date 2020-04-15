Class {
	#name : #CrSettingsPomodoroPanel,
	#superclass : #CrSettingsPanel,
	#instVars : [
		'light',
		'dark',
		'pomodoroDuration',
		'breakDuration',
		'longBreakDuration'
	],
	#category : #'Crono-View-Todo-Settings'
}

{ #category : #specs }
CrSettingsPomodoroPanel class >> defaultSpec [

	^ SpGridLayout new
		beRowNotHomogeneous;
		beColumnNotHomogeneous;
		columnSpacing: 5;
		add: 'Pomodoro duration' at: 1@1; add: #pomodoroDuration at: 2@1;
		add: 'Break duration' at: 1@2; add: #breakDuration at: 2@2;
		add: 'Long break duration' at: 1@3; add: #longBreakDuration at: 2@3;
		yourself
]

{ #category : #accessing }
CrSettingsPomodoroPanel class >> order [

	^ 20
]

{ #category : #initialization }
CrSettingsPomodoroPanel >> initializePresenters [

	pomodoroDuration := self newNumberInput
		number: self settings pomodoroDuration minutes;
		rangeMinimum: 1 maximum: 60;
		whenNumberChangedDo: [ :aNumber | self movePomodoroDurationTo: aNumber ];
		yourself.
		
	breakDuration := self newNumberInput
		number: self settings breakDuration minutes;
		rangeMinimum: 1 maximum: 10;
		whenNumberChangedDo: [ :aNumber | self moveBreakDurationTo: aNumber ];
		yourself.	
		
	longBreakDuration := self newNumberInput
		number: self settings longBreakDuration minutes;
		rangeMinimum: 1 maximum: 30;
		whenNumberChangedDo: [ :aNumber | self moveLongBreakDurationTo: aNumber ];
		yourself.
]

{ #category : #actions }
CrSettingsPomodoroPanel >> moveBreakDurationTo: aNumber [

	self settings 
		breakDuration: aNumber minutes;
		writeToFile
]

{ #category : #actions }
CrSettingsPomodoroPanel >> moveLongBreakDurationTo: aNumber [

	self settings 
		longBreakDuration: aNumber minutes;
		writeToFile
]

{ #category : #actions }
CrSettingsPomodoroPanel >> movePomodoroDurationTo: aNumber [

	self settings 
		pomodoroDuration: aNumber minutes;
		writeToFile
]

{ #category : #accessing }
CrSettingsPomodoroPanel >> settings [

	^ CrPomodoroConfiguration readFromFileSystem
]

{ #category : #accessing }
CrSettingsPomodoroPanel >> title [

	^ 'Pomodoro'
]
