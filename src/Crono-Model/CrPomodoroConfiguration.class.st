Class {
	#name : #CrPomodoroConfiguration,
	#superclass : #CrWindowConfiguration,
	#instVars : [
		'pomodoroDuration',
		'breakDuration',
		'longBreakDuration'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #defaults }
CrPomodoroConfiguration class >> defaultBreakDuration [

	^ 5 minutes
]

{ #category : #defaults }
CrPomodoroConfiguration class >> defaultLongBreakDuration [

	^ 15 minutes
]

{ #category : #defaults }
CrPomodoroConfiguration class >> defaultPomodoroDuration [

	^ 25 minutes
]

{ #category : #accessing }
CrPomodoroConfiguration class >> fileName [

	^ 'pomodoro.ston'
]

{ #category : #accessing }
CrPomodoroConfiguration >> breakDuration [

	^ breakDuration ifNil: [ breakDuration := self class defaultBreakDuration ]
]

{ #category : #accessing }
CrPomodoroConfiguration >> breakDuration: anObject [
	breakDuration := anObject
]

{ #category : #accessing }
CrPomodoroConfiguration >> defaultBounds [

	^ 0@0 extent: 180@120
]

{ #category : #accessing }
CrPomodoroConfiguration >> longBreakDuration [

	^ longBreakDuration ifNil: [ longBreakDuration := self class defaultLongBreakDuration ]
]

{ #category : #accessing }
CrPomodoroConfiguration >> longBreakDuration: anObject [
	longBreakDuration := anObject
]

{ #category : #accessing }
CrPomodoroConfiguration >> pomodoroDuration [

	^ pomodoroDuration ifNil: [ 
		pomodoroDuration := self class defaultPomodoroDuration ]
]

{ #category : #accessing }
CrPomodoroConfiguration >> pomodoroDuration: anObject [
	pomodoroDuration := anObject
]
