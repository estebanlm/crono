"
I am a panel to show a summary of a task.
Summary contains: title, completion, [project] and maybe other details.
"
Class {
	#name : #CrTodoListTaskSummaryPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'todoList',
		'doneCheckbox',
		'nameLabel',
		'listLabel',
		'task',
		'noteMarkerImage',
		'memento',
		'focusMarkerImage'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListTaskSummaryPanel class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		add: #doneCheckbox expand: false;
		add: #focusMarkerImage expand: false;
		add: #nameLabel;
		add: #listLabel expand: false;
		addLast: #noteMarkerImage expand: false;
		yourself
]

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> activeTask [

	^ self task
]

{ #category : #actions }
CrTodoListTaskSummaryPanel >> changeStatusTo: state [
	
	(CrTodoTaskChangeDoneStatusCommand forContext: self)
		state: state;
		execute
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> initializePresenters [

	doneCheckbox := self newCheckBox 
		whenChangedDo: [ :state | self changeStatusTo: state ].
	focusMarkerImage := self newImage addStyle: 'markFocus'.
	nameLabel := self newLabel.
	listLabel := self newLabel addStyle: 'listNameLabel'.
	noteMarkerImage := self newImage
]

{ #category : #accessing }
CrTodoListTaskSummaryPanel >> refreshContentIfNeeded [
	| newMemento |

	newMemento := self task takeMemento.
	memento = newMemento ifTrue: [ ^ self ].

	memento := newMemento.
	self updatePresenter
]

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> setModelBeforeInitialization: aTodoListAndTaskPair [

	todoList := aTodoListAndTaskPair todoList.
	task := aTodoListAndTaskPair task.
	memento := task takeMemento.
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

{ #category : #initialization }
CrTodoListTaskSummaryPanel >> updatePresenter [

	doneCheckbox state: task isDone.
	nameLabel label: task name.
	self todoList isVirtual ifTrue: [ 
		listLabel label: task listName ].
	task hasNotes 
		ifTrue: [ noteMarkerImage image: (self application iconNamed: #markNote) ]
		ifFalse: [ noteMarkerImage image: nil ].
	(self showsFocus and: [ task isFocused ])
		ifTrue: [ focusMarkerImage image: (self application iconNamed: #markFocus) ]
		ifFalse: [ focusMarkerImage image: nil ] 
]
