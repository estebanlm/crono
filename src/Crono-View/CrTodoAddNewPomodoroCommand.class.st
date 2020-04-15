Class {
	#name : #CrTodoAddNewPomodoroCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoAddNewPomodoroCommand class >> defaultDescription [

	^ 'Opens a new Pomodoro window.'
]

{ #category : #default }
CrTodoAddNewPomodoroCommand class >> defaultIconName [

	^ #pomodoro
]

{ #category : #default }
CrTodoAddNewPomodoroCommand class >> defaultName [

	^ 'Start a pomodoro on active task'
]

{ #category : #default }
CrTodoAddNewPomodoroCommand class >> defaultShortcut [

	^ $p platformMeta
]

{ #category : #executing }
CrTodoAddNewPomodoroCommand >> execute [
	
	(CrPomodoroWindow on: context activeTask) openWithSpec
]
