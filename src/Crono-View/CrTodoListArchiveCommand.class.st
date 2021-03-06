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

{ #category : #testing }
CrTodoListArchiveCommand >> canBeExecuted [

	^ self todoList isEditable
]

{ #category : #executing }
CrTodoListArchiveCommand >> execute [
	| list |
	
	list := self todoList.
	list toggleArchive.
	context refresh.

	context application notificationCenter
		notify: (CrListChangedNotification newList: list)
]

{ #category : #accessing }
CrTodoListArchiveCommand >> name [

	self todoList ifNil: [ ^ super name ].

	^ self todoList isArchived 
		ifTrue: [ 'Unarchive' ]
		ifFalse: [ 'Archive' ]
]
