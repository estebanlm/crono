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

{ #category : #'as yet unclassified' }
CrTodoMainWindow >> activeTask [

	^ listPanel presenter activeTask
]

{ #category : #initialization }
CrTodoMainWindow >> initialize [

	super initialize.
	CrModelApplication isDevelopment 
		ifTrue: [ self installMainMenuInWindow ]
]

{ #category : #initialization }
CrTodoMainWindow >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter menu: self menuBar
]

{ #category : #initialization }
CrTodoMainWindow >> installMainMenuInWindow [

	self menuBar: self mainMenu
]

{ #category : #private }
CrTodoMainWindow >> mainMenu [

	^ self mainMenuActions asMenuBarPresenter
]

{ #category : #private }
CrTodoMainWindow >> mainMenuActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'File') asSpecGroup
			register: ((CmCommandGroup named: 'Organisation') asSpecGroup
				beDisplayedAsGroup;
				register: (CrTodoTaskToggleFocusCommand forSpecContext: self);
				register: (CrTodoAddTaskCommand forSpecContext: self);
				register: (CrTodoTaskMoveCommand forSpecContext: self);
				yourself);
			register: ((CmCommandGroup named: 'Critical') asSpecGroup
				beDisplayedAsGroup;
				register: (CrTodoArchiveCompletedCommand forSpecContext: self);
				register: (CrTodoTaskArchiveCommand forSpecContext: self);
				register: (CrTodoTaskDeleteCommand forSpecContext: self);
				yourself);
			yourself);
		register: ((CmCommandGroup named: 'View') asSpecGroup
			register: (CrTodoViewArchivedCommand forSpecContext: self);
			yourself);
		yourself	
]

{ #category : #accessing }
CrTodoMainWindow >> menuBar [

	^ menuBar
]

{ #category : #accessing }
CrTodoMainWindow >> menuBar: aMenuPresenter [

	menuBar := aMenuPresenter
]

{ #category : #'as yet unclassified' }
CrTodoMainWindow >> shownArchived [
	
	^ listPanel presenter shownArchived
]
