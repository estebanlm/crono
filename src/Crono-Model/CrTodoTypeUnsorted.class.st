"
I'm a list type unsorted.
"
Class {
	#name : #CrTodoTypeUnsorted,
	#superclass : #CrTodoType,
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTypeUnsorted >> defaultIconName [

	^ #waiting
]

{ #category : #accessing }
CrTodoTypeUnsorted >> name [
	
	^ 'Unsorted'
]

{ #category : #testing }
CrTodoTypeUnsorted >> showsCompletion [

	^ false
]

{ #category : #testing }
CrTodoTypeUnsorted >> showsPendingSize [

	^ true
]

{ #category : #accessing }
CrTodoTypeUnsorted >> typeName [

	^ #unsorted
]
