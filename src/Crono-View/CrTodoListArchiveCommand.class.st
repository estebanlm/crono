Class {
	#name : #CrTodoListArchiveCommand,
	#superclass : #CrTodoListCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoListArchiveCommand class >> defaultDescription [

	^ 'Archive this todo list (and all its tasks).'
]

{ #category : #default }
CrTodoListArchiveCommand class >> defaultName [

	^ 'Archive'
]

{ #category : #default }
CrTodoListArchiveCommand class >> defaultShortcut [

	^ $a platformMeta
]

{ #category : #executing }
CrTodoListArchiveCommand >> execute [
	
	self todoList isArchived 
		ifTrue: [ self todoList unarchive ]
		ifFalse: [ self todoList archive ].
	context refresh.

	context application notificationCenter
		notify: (CrListChangedNotification newList: self todoList)
]

{ #category : #accessing }
CrTodoListArchiveCommand >> name [

	self todoList ifNil: [ ^ super name ].

	^ self todoList isArchived 
		ifTrue: [ 'Unarchive' ]
		ifFalse: [ 'Archive' ]
]
