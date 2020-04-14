Class {
	#name : #CrPomodoroConfiguration,
	#superclass : #CrWindowConfiguration,
	#instVars : [
		'pomodoroDuration'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #defaults }
CrPomodoroConfiguration class >> defaultPomodoroDuration [

	^ 25 minutes
]

{ #category : #accessing }
CrPomodoroConfiguration class >> fileName [

	^ 'pomodoro.ston'
]

{ #category : #accessing }
CrPomodoroConfiguration >> defaultBounds [

	^ 0@0 extent: 180@120
]

{ #category : #accessing }
CrPomodoroConfiguration >> pomodoroDuration [

	^ pomodoroDuration ifNil: [ 
		pomodoroDuration := self class defaultPomodoroDuration ]
]
