"
I notify when a task belonging to a virtual list (focus, etc.) changed. 
This usually means we need to impact the changes in more than one visible list.
For example, if I complete a task in ""inbox"" that is focused, the pending tasks marker needs to be reflected in ""inbox"" summary item (in CrTodoListIndexPanel) and in ""focus"" summary item.
"
Class {
	#name : #CrVirtualListTaskChangedNotification,
	#superclass : #CrListChangedNotification,
	#instVars : [
		'task'
	],
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #'instance creation' }
CrVirtualListTaskChangedNotification class >> newList: aTodoList task: aTask [

	^ self new 
		list: aTodoList;
		task: aTask;
		yourself
]

{ #category : #accessing }
CrVirtualListTaskChangedNotification class >> receiverSelector [

	^ #noteVirtualListTaskChanged:
]

{ #category : #accessing }
CrVirtualListTaskChangedNotification >> task [
	^ task
]

{ #category : #accessing }
CrVirtualListTaskChangedNotification >> task: anObject [
	task := anObject
]
