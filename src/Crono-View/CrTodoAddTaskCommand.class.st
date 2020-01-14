Class {
	#name : #CrTodoAddTaskCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoAddTaskCommand class >> defaultDescription [

	^ 'Add a new task to the current active list.'
]

{ #category : #default }
CrTodoAddTaskCommand class >> defaultIconName [

	^ #add
]

{ #category : #default }
CrTodoAddTaskCommand class >> defaultName [

	^ 'New Task'
]

{ #category : #default }
CrTodoAddTaskCommand class >> defaultShortcut [

	^ $n platformMeta
]

{ #category : #executing }
CrTodoAddTaskCommand >> execute [
	
	(CrTodoAddTaskPanel newApplication: self application)
		todoList: self todoList;
		openDialogWithSpecParent: context window
]

{ #category : #accessing }
CrTodoAddTaskCommand >> todoList [
	
	^ context activeTodoList
]
