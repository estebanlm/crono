Class {
	#name : #CrTodoWindowConfiguration,
	#superclass : #CrWindowConfiguration,
	#category : #'Crono-View-Configuration'
}

{ #category : #accessing }
CrTodoWindowConfiguration class >> fileName [

	^ 'todo.ston'
]

{ #category : #accessing }
CrTodoWindowConfiguration >> defaultBounds [

	^ 0@0 extent: 800@600
]
