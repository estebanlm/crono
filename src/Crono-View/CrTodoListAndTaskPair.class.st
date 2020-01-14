"
I am a pair todolist->task. 
I keep the relation between a list and its tasks, in order to be transmited to UI users.

e.g. CrTodoListTaskSummaryPanel, who requires both as model to correctly show its contents.
"
Class {
	#name : #CrTodoListAndTaskPair,
	#superclass : #Object,
	#instVars : [
		'todoList',
		'task'
	],
	#category : #'Crono-View-Todo-Utils'
}

{ #category : #'instance creation' }
CrTodoListAndTaskPair class >> newList: aTodoList task: aTask [ 
	
	^ self new 
		todoList: aTodoList;
		task: aTask;
		yourself
]

{ #category : #accessing }
CrTodoListAndTaskPair >> task [
	^ task
]

{ #category : #accessing }
CrTodoListAndTaskPair >> task: anObject [
	task := anObject
]

{ #category : #accessing }
CrTodoListAndTaskPair >> todoList [
	^ todoList
]

{ #category : #accessing }
CrTodoListAndTaskPair >> todoList: anObject [
	todoList := anObject
]
