Class {
	#name : #CrTodoViewArchivedCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoViewArchivedCommand class >> defaultDescription [

	^ 'View archived tasks.'
]

{ #category : #default }
CrTodoViewArchivedCommand class >> defaultName [

	^ 'View Archived'
]

{ #category : #executing }
CrTodoViewArchivedCommand >> execute [
	
	context toggleShownArchived
]

{ #category : #accessing }
CrTodoViewArchivedCommand >> name [

	^ context shownArchived
		ifTrue: [ 'Hide Archived' ]
		ifFalse: [ 'Show Archived' ]
]
