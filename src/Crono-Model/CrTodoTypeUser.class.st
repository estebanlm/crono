"
I'm a list type user.
"
Class {
	#name : #CrTodoTypeUser,
	#superclass : #CrTodoType,
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTypeUser >> defaultIconName [

	^ #user
]

{ #category : #accessing }
CrTodoTypeUser >> defaultName [

	^ 'New list'
]

{ #category : #testing }
CrTodoTypeUser >> isEditable [

	^ true
]

{ #category : #accessing }
CrTodoTypeUser >> name [
	
	^ 'User'
]

{ #category : #accessing }
CrTodoTypeUser >> typeName [

	^ #user
]
