"
I'm a todo window made to be shown as main window of the application.
In windows and linux, closing this window means to close the full application.
"
Class {
	#name : #CrTodoMainWindow,
	#superclass : #CrTodoWindow,
	#instVars : [
		'menuBar'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #initialization }
CrTodoMainWindow >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter menu: self menuBar 
]

{ #category : #accessing }
CrTodoMainWindow >> menuBar [

	^ menuBar
]

{ #category : #accessing }
CrTodoMainWindow >> menuBar: aMenuPresenter [

	menuBar := aMenuPresenter
]
