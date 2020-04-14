"
I'm a list type inbox.
"
Class {
	#name : #CrTodoTypeInbox,
	#superclass : #CrTodoType,
	#category : #'Crono-Model-Todo'
}

{ #category : #accessing }
CrTodoTypeInbox >> defaultIconName [

	^ #inbox
]

{ #category : #accessing }
CrTodoTypeInbox >> name [
	
	^ 'Inbox'
]

{ #category : #testing }
CrTodoTypeInbox >> showsCompletion [

	^ false
]

{ #category : #testing }
CrTodoTypeInbox >> showsPendingSize [

	^ true
]

{ #category : #accessing }
CrTodoTypeInbox >> typeName [

	^ #inbox
]
