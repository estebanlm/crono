"
I'm a status bar for a list panel.
"
Class {
	#name : #CrTodoListStatusBarPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'todoList',
		'summaryLabel'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListStatusBarPanel class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		add: #summaryLabel;
		yourself
]

{ #category : #initialization }
CrTodoListStatusBarPanel >> initializePresenter [

	summaryLabel := self newLabel.

	self refresh
]

{ #category : #accessing }
CrTodoListStatusBarPanel >> refresh [

	summaryLabel label: (self todoList ifNotNil: #summaryString)
]

{ #category : #initialization }
CrTodoListStatusBarPanel >> setModelBeforeInitialization: aTodoList [

	todoList := aTodoList
]

{ #category : #accessing }
CrTodoListStatusBarPanel >> todoList [

	^ todoList
]

{ #category : #accessing }
CrTodoListStatusBarPanel >> todoList: aTodoList [

	todoList := aTodoList.
	self refresh
]
