"
I create a new ""crono"" (a task done)
"
Class {
	#name : #CrTodoAddNewCronoCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoAddNewCronoCommand class >> defaultDescription [

	^ 'Add a new DONE unsorted task.'
]

{ #category : #default }
CrTodoAddNewCronoCommand class >> defaultIconName [

	^ #done
]

{ #category : #default }
CrTodoAddNewCronoCommand class >> defaultName [

	^ 'New DONE Task'
]

{ #category : #default }
CrTodoAddNewCronoCommand class >> defaultShortcut [

	^ $d platformMeta
]

{ #category : #executing }
CrTodoAddNewCronoCommand >> execute [
	
	CrCronoDialog new openDialogWithSpecParent: context window
]