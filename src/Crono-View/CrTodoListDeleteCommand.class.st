Class {
	#name : #CrTodoListDeleteCommand,
	#superclass : #CrTodoListCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoListDeleteCommand class >> defaultDescription [

	^ 'Delete this todo list (and all its tasks).'
]

{ #category : #default }
CrTodoListDeleteCommand class >> defaultName [

	^ 'Delete'
]

{ #category : #default }
CrTodoListDeleteCommand class >> defaultShortcut [

	^ $x platformMeta
]