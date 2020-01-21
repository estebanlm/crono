Class {
	#name : #CrTodoListCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #accessing }
CrTodoListCommand >> todoList [

	^ context activeTodoList
]
