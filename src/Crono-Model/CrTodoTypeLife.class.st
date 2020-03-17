"
I'm a list type ""life"" (general life tasks).
"
Class {
	#name : #CrTodoTypeLife,
	#superclass : #CrTodoType,
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTypeLife >> defaultIconName [

	^ #life
]

{ #category : #accessing }
CrTodoTypeLife >> name [
	
	^ 'Life'
]

{ #category : #testing }
CrTodoTypeLife >> showsCompletion [

	^ false
]

{ #category : #testing }
CrTodoTypeLife >> showsPendingSize [

	^ true
]

{ #category : #accessing }
CrTodoTypeLife >> typeName [

	^ #life
]
