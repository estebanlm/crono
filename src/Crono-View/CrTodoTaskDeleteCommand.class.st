Class {
	#name : #CrTodoTaskDeleteCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoTaskDeleteCommand class >> defaultDescription [

	^ 'Delete task.'
]

{ #category : #default }
CrTodoTaskDeleteCommand class >> defaultName [

	^ 'Delete'
]

{ #category : #default }
CrTodoTaskDeleteCommand class >> defaultShortcut [

	^ $x platformMeta
]

{ #category : #executing }
CrTodoTaskDeleteCommand >> execute [
	| ok focused |
	
	ok := (CrConfirmDialog new 
		title: 'Delete Task';
		label: ('You are about to delete "{1}"' format: { self task name });
		openDialogWithSpecParent: context window)
		isOk.
	ok ifFalse: [ ^ self ].
	
	focused := self task isFocused.
	self todoList 
		removeTask: self task 
		follow: true.
	context refresh.
	
	context application notificationCenter
		notify: (CrTaskChangedNotification newTask: self task);
		notify: (CrListChangedNotification newList: self todoList).
	focused ifTrue: [ 
		context application notificationCenter
			notify: (CrListChangedNotification newList: CrTodoList focus) ]
]

{ #category : #accessing }
CrTodoTaskDeleteCommand >> task [

	^ context activeTask
]

{ #category : #accessing }
CrTodoTaskDeleteCommand >> todoList [

	^ context activeTodoList
]
