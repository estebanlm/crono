Class {
	#name : #CrTodoTaskStartPomodoroCommand,
	#superclass : #CrTodoTaskCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoTaskStartPomodoroCommand class >> defaultDescription [

	^ 'Opens a new Pomodoro window.'
]

{ #category : #default }
CrTodoTaskStartPomodoroCommand class >> defaultIconName [

	^ 'pomodoro-indicator'
]

{ #category : #default }
CrTodoTaskStartPomodoroCommand class >> defaultName [

	^ 'Start Pomodoro'
]

{ #category : #default }
CrTodoTaskStartPomodoroCommand class >> defaultShortcut [

	^ $p platformMeta
]

{ #category : #executing }
CrTodoTaskStartPomodoroCommand >> execute [
	
	(CrPomodoroWindow on: self task newPomodoroTask) openWithSpec
]
