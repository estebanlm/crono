Class {
	#name : #CrTodoEditTaskPanel,
	#superclass : #CrTodoTaskPanel,
	#instVars : [
		'task'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #initialization }
CrTodoEditTaskPanel >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: 'Update'
			do: [ :presenter |
				self updateTaskThen: [ 
					presenter 
						beOk; 
						close ] ]
]

{ #category : #initialization }
CrTodoEditTaskPanel >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: ('Edit "{1}"' format: { self task shortName })
]

{ #category : #accessing }
CrTodoEditTaskPanel >> task [
	^ task
]

{ #category : #accessing }
CrTodoEditTaskPanel >> task: aTask [

	task := aTask.
	nameTextInput text: task name. 
	notesText text: task notes. 
	doneCheckbox state: task isDone.
]

{ #category : #actions }
CrTodoEditTaskPanel >> updateTaskThen: aBlock [

	self validate ifFalse: [ ^ self ].

	task
		name: nameTextInput text asString trimmed;
		notes: notesText text asString trimmed;
		done: doneCheckbox state;
		save.
	
	self application notificationCenter 
		notify: (CrTaskAddedNotification newTask: task);
		notify: (CrListChangedNotification newList: self todoList).

	aBlock value
]
