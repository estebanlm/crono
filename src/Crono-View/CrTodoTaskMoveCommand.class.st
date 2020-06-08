Class {
	#name : #CrTodoTaskMoveCommand,
	#superclass : #CrTodoTaskCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoTaskMoveCommand class >> defaultDescription [

	^ 'Change the focus status of a task.'
]

{ #category : #default }
CrTodoTaskMoveCommand class >> defaultName [

	^ 'Move'
]

{ #category : #default }
CrTodoTaskMoveCommand class >> defaultShortcut [

	^ $m platformMeta
]

{ #category : #testing }
CrTodoTaskMoveCommand >> canBeExecuted [

	^ self todoList isVirtual not
		or: [ self todoList type = CrTodoType focus ]
]

{ #category : #executing }
CrTodoTaskMoveCommand >> execute [
	| dialog task |

	task := self task. "keep task because if this is moved, selection will be lost"
	dialog := CrMoveToDialog new 
		task: self task;
		todoList: self todoList;
		openDialogWithSpecParent: context window.

	self application notificationCenter 
		notify: (CrListChangedNotification newList: self todoList);
		notify: (CrListChangedNotification newList: dialog presenter selectedItem).	
	task isFocused ifTrue: [ 
		self application notificationCenter 
			notify: (CrVirtualListTaskChangedNotification 
				newList: CrTodoList focus
				task: task) ]
]

{ #category : #accessing }
CrTodoTaskMoveCommand >> todoList [

	^ context activeTodoList
]
