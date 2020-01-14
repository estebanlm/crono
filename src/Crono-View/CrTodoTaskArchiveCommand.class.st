Class {
	#name : #CrTodoTaskArchiveCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoTaskArchiveCommand class >> defaultDescription [

	^ 'Move task to archive.'
]

{ #category : #default }
CrTodoTaskArchiveCommand class >> defaultName [

	^ 'Archive'
]

{ #category : #default }
CrTodoTaskArchiveCommand class >> defaultShortcut [

	^ $a platformMeta
]

{ #category : #executing }
CrTodoTaskArchiveCommand >> execute [
	
	self task isArchived 
		ifTrue: [ self task unarchive ]
		ifFalse: [ self task archive ].
	context refresh.

	context application notificationCenter
		notify: (CrTaskChangedNotification newTask: self task);
		notify: (CrListChangedNotification newList: self todoList)
]

{ #category : #accessing }
CrTodoTaskArchiveCommand >> name [

	self task ifNil: [ ^ super name ].
	^ self task isArchived 
		ifTrue: [ 'Unarchive' ]
		ifFalse: [ 'Archive' ]
]

{ #category : #accessing }
CrTodoTaskArchiveCommand >> task [

	^ context activeTask
]

{ #category : #accessing }
CrTodoTaskArchiveCommand >> todoList [

	^ context activeTodoList
]
