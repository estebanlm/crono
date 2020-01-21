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
