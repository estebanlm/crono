"
I am a copy of class CrTodoAddNewCronoCommand. This comment is copied from there, and might not be entirely accurate

I create a new ""crono"" (a task done)
"
Class {
	#name : #CrTodoReviewCronoCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoReviewCronoCommand class >> defaultDescription [

	^ 'Review done tasks.'
]

{ #category : #default }
CrTodoReviewCronoCommand class >> defaultIconName [

	^ #reviewDone
]

{ #category : #default }
CrTodoReviewCronoCommand class >> defaultName [

	^ 'Review'
]

{ #category : #default }
CrTodoReviewCronoCommand class >> defaultShortcut [

	^ $r platformMeta
]

{ #category : #executing }
CrTodoReviewCronoCommand >> execute [
	
	CrReviewWindow open
]
