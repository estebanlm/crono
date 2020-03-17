"
I am a panel to show a summary of a todo list.
I am meant to be shown as the index of todo lists.
Summary contains: icon, title and maybe other details.
"
Class {
	#name : #CrTodoListIndexSummaryPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'todoList',
		'iconImage',
		'nameLabel',
		'statusLabel'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListIndexSummaryPanel class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		"borderWidth: 3;"
		spacing: 5;
		add: #iconImage expand: false;
		add: #nameLabel;
		addLast: #statusLabel expand: false;
		yourself
]

{ #category : #'private accessing' }
CrTodoListIndexSummaryPanel >> image [
	
	^ self todoList iconOn: self application
]

{ #category : #initialization }
CrTodoListIndexSummaryPanel >> initializePresenters [

	iconImage := self newImage image: self image.
	nameLabel := self newLabel label: self todoList name.
	statusLabel := self newLabel label: self statusString

]

{ #category : #accessing }
CrTodoListIndexSummaryPanel >> refresh [

	self updateName.
	self updateStatus.
	self updateImage
]

{ #category : #initialization }
CrTodoListIndexSummaryPanel >> setModelBeforeInitialization: aTodoList [

	todoList := aTodoList
]

{ #category : #accessing }
CrTodoListIndexSummaryPanel >> showsCompletion [

	^ self todoList showsCompletion
]

{ #category : #accessing }
CrTodoListIndexSummaryPanel >> showsPendingSize [

	^ self todoList showsPendingSize
]

{ #category : #'private accessing' }
CrTodoListIndexSummaryPanel >> statusString [
	| listSize |

	self showsPendingSize ifFalse: [ ^ '' ].

	listSize := self todoListPendingSize.
	^ listSize ~= 0 
		ifTrue: [ listSize printString ] 
		ifFalse: [ '' ]
]

{ #category : #accessing }
CrTodoListIndexSummaryPanel >> todoList [

	^ todoList
]

{ #category : #accessing }
CrTodoListIndexSummaryPanel >> todoListPendingSize [

	^ self todoList pendingTasksSize
]

{ #category : #'private updating' }
CrTodoListIndexSummaryPanel >> updateImage [

	self todoList showsCompletion ifFalse: [ ^ self ].
	
	iconImage image: (self todoList iconOn: self application)	
	
]

{ #category : #'private updating' }
CrTodoListIndexSummaryPanel >> updateName [

	nameLabel label: self todoList name
]

{ #category : #'private updating' }
CrTodoListIndexSummaryPanel >> updateStatus [

	self showsPendingSize ifFalse: [ ^ self ].

	statusLabel label: self statusString
]
