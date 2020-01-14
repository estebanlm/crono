Class {
	#name : #CrModelApplicationForTest,
	#superclass : #CrModelApplication,
	#category : #'Crono-Tests'
}

{ #category : #'instance creation' }
CrModelApplicationForTest class >> new [ 

	^ self basicNew initialize
]

{ #category : #initialization }
CrModelApplicationForTest >> initializeCronoRepository [

	cronoRepository := VOUnQLiteRepository onMemory.
]

{ #category : #initialization }
CrModelApplicationForTest >> initializeRepository [
	
	repository := VOUnQLiteRepository onMemory.
	CrTodoList newBaseLists 
		do: [ :each | repository save: each ]
]
