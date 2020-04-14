Class {
	#name : #CrPomodoroTaskTest,
	#superclass : #CrTestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrPomodoroTaskTest >> testNewTaskWithCronoTask [
	| pom |
	
	pom := CrPomodoroTask newTask: (CrCronoTask new 
		notes: 'Test
multi
line';
		yourself).
	
	self assert: pom name equals: 'Test'
]
