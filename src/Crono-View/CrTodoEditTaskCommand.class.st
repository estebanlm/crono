"
I edit a task.
"
Class {
	#name : #CrTodoEditTaskCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoEditTaskCommand class >> defaultDescription [

	^ 'Edits a task.'
]

{ #category : #default }
CrTodoEditTaskCommand class >> defaultName [

	^ 'Edit Task'
]

{ #category : #executing }
CrTodoEditTaskCommand >> execute [
	
	(CrTodoEditTaskPanel newApplication: self application)
		todoList: self todoList;
		task: self task;
		openDialogWithSpecParent: context window
]

{ #category : #accessing }
CrTodoEditTaskCommand >> task [

	^ context activeTask
]

{ #category : #accessing }
CrTodoEditTaskCommand >> todoList [
	
	^ context activeTodoList
]
