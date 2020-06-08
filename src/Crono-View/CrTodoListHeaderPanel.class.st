"
! CrTodoListHeaderPanel

A group header panel to present tasks in Focus panel (tasks will be grouped by todo list there). 
"
Class {
	#name : #CrTodoListHeaderPanel,
	#superclass : #CrPresenter,
	#instVars : [
		'todoList',
		'nameLabel',
		'iconImage'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListHeaderPanel class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		borderWidth: 5;
		spacing: 5;
		add: #iconImage expand: false;
		add: #nameLabel;
		yourself
]

{ #category : #testing }
CrTodoListHeaderPanel >> canTakeKeyboardFocus [

	^ false
]

{ #category : #initialization }
CrTodoListHeaderPanel >> initializePresenters [

	iconImage := self newImage.
	nameLabel := self newLabel 
		addStyle: 'listNameLabel';
		yourself
]

{ #category : #testing }
CrTodoListHeaderPanel >> isActivatable [

	^ false
]

{ #category : #testing }
CrTodoListHeaderPanel >> isSelectable [

	^ false
]

{ #category : #testing }
CrTodoListHeaderPanel >> matchesTask: aTask [

	^ self todoList includesTask: aTask
]

{ #category : #accessing }
CrTodoListHeaderPanel >> refreshContentIfNeeded [

	self updatePresenter
]

{ #category : #'accessing model' }
CrTodoListHeaderPanel >> setModelBeforeInitialization: aTodoList [

	todoList := aTodoList
]

{ #category : #accessing }
CrTodoListHeaderPanel >> todoList [

	^ todoList
]

{ #category : #initialization }
CrTodoListHeaderPanel >> updatePresenter [

	iconImage image: (self todoList iconOn: self application).
	nameLabel label: self todoList name
]
