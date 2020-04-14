Class {
	#name : #CrPomodoroTask,
	#superclass : #Object,
	#instVars : [
		'timer',
		'ownerTask'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #'instance creation' }
CrPomodoroTask class >> newTask: aTask [ 

	^ self new 
		ownerTask: aTask;
		yourself
]

{ #category : #initialization }
CrPomodoroTask >> initialize [
	
	super initialize.
	timer := CrPomodoroTimer newDuration: self settings pomodoroDuration
]

{ #category : #testing }
CrPomodoroTask >> isFinished [

	^ timer isFinished
]

{ #category : #testing }
CrPomodoroTask >> isStopped [

	^ timer isStopped
]

{ #category : #accessing }
CrPomodoroTask >> name [

	^ self ownerTask pomodoroName
]

{ #category : #accessing }
CrPomodoroTask >> ownerTask [

	^ ownerTask
]

{ #category : #accessing }
CrPomodoroTask >> ownerTask: aTask [

	ownerTask := aTask
]

{ #category : #accessing }
CrPomodoroTask >> remainingTime [
	
	^ timer remainingTime
]

{ #category : #initialization }
CrPomodoroTask >> settings [

	^ CrPomodoroConfiguration readFromFileSystem
]

{ #category : #actions }
CrPomodoroTask >> start [

	timer start
]

{ #category : #actions }
CrPomodoroTask >> stop [

	timer stop
]
