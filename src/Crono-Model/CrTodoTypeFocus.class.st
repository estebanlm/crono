"
I'm a list type focus.
"
Class {
	#name : #CrTodoTypeFocus,
	#superclass : #CrTodoType,
	#category : #'Crono-Model-Todo'
}

{ #category : #accessing }
CrTodoTypeFocus >> defaultIconName [

	^ #active
]

{ #category : #accessing }
CrTodoTypeFocus >> name [
	
	^ 'Focus'
]

{ #category : #testing }
CrTodoTypeFocus >> showsCompletion [

	^ false
]

{ #category : #testing }
CrTodoTypeFocus >> showsFocus [

	^ false
]

{ #category : #testing }
CrTodoTypeFocus >> showsPendingSize [

	^ true
]

{ #category : #accessing }
CrTodoTypeFocus >> typeName [

	^ #focus
]
