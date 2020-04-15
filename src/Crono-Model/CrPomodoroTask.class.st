Class {
	#name : #CrPomodoroTask,
	#superclass : #Object,
	#instVars : [
		'timer',
		'ownerTask',
		'timeStart',
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
CrPomodoroTask class >> voyageTick [
	<voyageDescription>
	
	^ VOTransientDescription new 
		attributeName: 'timer';
		yourself
]

{ #category : #private }
CrPomodoroTask >> completed [ 

	completed := true.
	self ownerTask addPomodoroTask: self copy
]

{ #category : #initialization }
CrPomodoroTask >> initialize [

	super initialize.
	completed := false.
	timer := CrPomodoroTimer newDuration: self settings pomodoroDuration.
	timer onCompleted: [ self completed ]
]

{ #category : #testing }
CrPomodoroTask >> isStopped [

	^ timer isStopped
]

{ #category : #accessing }
CrPomodoroTask >> name [

	^ self ownerTask pomodoroName
]

{ #category : #events }
CrPomodoroTask >> onTick: aBlock [

	timer onTick: aBlock
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

	timer start.
	timeStart := ZTimestamp now	
]

{ #category : #actions }
CrPomodoroTask >> stop [

	timer stop
]

{ #category : #accessing }
CrPomodoroTask >> timer [

	^ timer
]
