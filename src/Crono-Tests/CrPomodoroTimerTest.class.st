Class {
	#name : #CrPomodoroTimerTest,
	#superclass : #TestCase,
	#instVars : [
		'timer'
	],
	#category : #'Crono-Tests'
}

{ #category : #running }
CrPomodoroTimerTest >> tearDown [

	timer ifNil: [ ^ self ].
	timer stop
]

{ #category : #tests }
CrPomodoroTimerTest >> testOnCompleted [
	| completed |
	
	timer := CrPomodoroTimer newDuration: 1 second.
	completed := false.
	timer onCompleted: [ completed := true ].
	timer start.
	1 second wait.
	self assert: completed.	

]

{ #category : #tests }
CrPomodoroTimerTest >> testOnTick [
	| completed |
	
	timer := CrPomodoroTimer newDuration: 3 second.
	completed := 0.
	timer onTick: [ completed := completed + 1 ].
	timer start.
	3 second wait.
	self assert: completed equals: 3
]
