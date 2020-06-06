"
I am a panel to show a summary of a task.
Summary contains: title, completion, [project] and maybe other details.
"
Class {
	#name : #CrTodoListTaskSummaryPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'task',
		'memento',
		'todoList',
		'doneCheckbox'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> activeTask [

	^ self task
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> addFocusMarkTo: aLayout [
	| mark |

	self showsFocus ifFalse: [ ^ self ].
	
	aLayout add: (mark := self newImage) expand: false.
	mark addStyle: 'mark'.
	mark image: (task isFocused
		ifTrue: [ self application iconNamed: #markFocus ]
		ifFalse: [ nil ])
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> addLayoutTo: newLayout [
	| nameLabel |
	
	newLayout add: (doneCheckbox := self newCheckBox) expand: false.
	doneCheckbox state: task isDone.
	doneCheckbox whenChangedDo: [ :state | self changeStatusTo: state ].	

	self addFocusMarkTo: newLayout.
	self addNoteMarkTo: newLayout.
	self addPomodoroMarkTo: newLayout.

	newLayout add: 	(nameLabel := self newLabel).
	nameLabel label: task name.
	
	self addListTo: newLayout
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> addListTo: aLayout [
	| listLabel |

	self todoList isVirtual ifFalse: [ ^ self ].
	 
	aLayout addLast: (listLabel := self newLabel) expand: false.
	listLabel label: task listName.
	listLabel addStyle: 'listNameLabel'
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> addNoteMarkTo: aLayout [
	| mark |

	task hasNotes ifFalse: [ ^ self ].

	aLayout add: (mark := self newImage) expand: false.
	mark  addStyle: 'mark'.
	mark image: (self application iconNamed: #markNote)
	

]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> addPomodoroMarkTo: aLayout [
	| mark |

	task hasPomodoroTasks ifFalse: [ ^ self ].

	aLayout add: (mark := self newImage) expand: false.
	mark  addStyle: 'mark'.
	mark image: (self application iconNamed: #markPomodoro)	

]

{ #category : #actions }
CrTodoListTaskSummaryPanel >> changeStatusTo: state [
	
	(CrTodoTaskChangeDoneStatusCommand forContext: self)
		state: state;
		execute
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> initializePresenters [
	| newLayout |
	
	newLayout := SpBoxLayout newHorizontal.
	self addLayoutTo: newLayout.
	self layout: newLayout
]

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> refreshContentIfNeeded [
	| newMemento |

	newMemento := self task takeMemento.
	memento = newMemento ifTrue: [ ^ self ].

	memento := newMemento.
	self layout removeAll.
	self addLayoutTo: self layout
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> setModelBeforeInitialization: aTodoListAndTaskPair [

	todoList := aTodoListAndTaskPair todoList.
	task := aTodoListAndTaskPair task.
	memento := task takeMemento
]

{ #category : #testing }
CrTodoListTaskSummaryPanel >> showsFocus [

	^ self todoList showsFocus
]

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> task [

	^ task
]

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> todoList [
	^ todoList
]

{ #category : #actions }
CrTodoListTaskSummaryPanel >> toggleFocus [
	
	(CrTodoTaskToggleFocusCommand forContext: self) execute
]

{ #category : #actions }
CrTodoListTaskSummaryPanel >> toggleState [

	"this will fire the change event, which is where the actual change happens (in 
	 #changeStatusTo:"
	doneCheckbox state: doneCheckbox state not
]
