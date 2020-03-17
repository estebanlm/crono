"
I'm a list type search... to show search results.
"
Class {
	#name : #CrTodoTypeSearch,
	#superclass : #CrTodoType,
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTypeSearch >> defaultIconName [

	^ #search
]

{ #category : #accessing }
CrTodoTypeSearch >> name [
	
	^ 'Search'
]

{ #category : #testing }
CrTodoTypeSearch >> showsCompletion [

	^ false
]

{ #category : #testing }
CrTodoTypeSearch >> showsFocus [

	^ true
]

{ #category : #testing }
CrTodoTypeSearch >> showsPendingSize [

	^ true
]

{ #category : #accessing }
CrTodoTypeSearch >> typeName [

	^ 'search'
]
