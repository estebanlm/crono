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

{ #category : #executing }
CrTodoListDeleteCommand >> execute [
	| ok todoList |
	
	todoList := self todoList.
	
	ok := (CrConfirmDialog new 
		title: 'Delete Todo List';
		label: ('You are about to delete "{1}" and all its tasks' format: { todoList name });
		openDialogWithSpecParent: context window)
		isOk.
	ok ifFalse: [ ^ self ].
	
	todoList remove.
	context refresh
]
