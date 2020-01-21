Class {
	#name : #CrTodoAddTaskPanel,
	#superclass : #CrTodoTaskPanel,
	#category : #'Crono-View-Todo'
}

{ #category : #actions }
CrTodoAddTaskPanel >> addTaskThen: aBlock [
	| task |

	self validate ifFalse: [ ^ self ].

	task := CrTodoTask new
		name: nameTextInput text asString trimmed;
		notes: notesText text asString trimmed;
		done: doneCheckbox state;
		yourself.
	
	self todoList saveTask: task.
	
	self application notificationCenter 
		notify: (CrTaskAddedNotification newTask: task);
		notify: (CrListChangedNotification newList: self todoList).

	aBlock value
]

{ #category : #initialization }
CrTodoAddTaskPanel >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.	
	aDialogWindowPresenter 
		addButton: 'Cancel' do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: 'Add'
			do: [ :presenter |
				self addTaskThen: [ 
					presenter 
						beOk; 
						close ] ]
]

{ #category : #initialization }
CrTodoAddTaskPanel >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: ('Add task to {1}' format: { self todoList name })

]
