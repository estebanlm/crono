"
I am a dialog to move a task from a list to another.
"
Class {
	#name : #CrMoveToDialog,
	#superclass : #CrPresenter,
	#instVars : [
		'list',
		'todoList',
		'task'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrMoveToDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #list;
		yourself
]

{ #category : #initialization }
CrMoveToDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter 
		addButton: 'Cancel' do: [ :presenter | 
			presenter beCancel; close ];
		addDefaultButton: 'Move' do: [ :presenter | 
			self moveTaskThen: [ presenter beOk; close ] ]
]

{ #category : #initialization }
CrMoveToDialog >> initializePresenter [

	list := self newList
		        display: [ :each | each name ];
		        displayIcon: [ :each | each iconOn: self application ];
		        whenActivatedDo: [ self moveTask ];
		        yourself
]

{ #category : #initialization }
CrMoveToDialog >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: ('Move "{1}" To...' format: { self task shortName })
]

{ #category : #accessing }
CrMoveToDialog >> lists [

	^ (CrTodoList activeLists copyWithout: self todoList) 
		sorted: [ :a | a isUser ] ascending, [ :a | a name ] ascending
]

{ #category : #actions }
CrMoveToDialog >> moveTask [

	self moveTaskThen: [ 
		self window 
			beOk;
			close ]
]

{ #category : #actions }
CrMoveToDialog >> moveTaskThen: aBlock [
	
	self todoList 
		moveTask: self task
		to: self selectedItem.
	aBlock value
]

{ #category : #accessing }
CrMoveToDialog >> refresh [ 

	list items: self lists
]

{ #category : #accessing }
CrMoveToDialog >> selectedItem [

	^ list selection selectedItem
]

{ #category : #accessing }
CrMoveToDialog >> task [
	^ task
]

{ #category : #accessing }
CrMoveToDialog >> task: anObject [
	task := anObject
]

{ #category : #accessing }
CrMoveToDialog >> todoList [
	^ todoList
]

{ #category : #accessing }
CrMoveToDialog >> todoList: aTodoList [

	todoList := aTodoList.
	self refresh
]
