"
! CrTaskPresenterCollector

An visitor to collect presenters for *class:CrTodoListPanel*
Each kind of list can organise deferently how it shows its contents (for example this is the case of Focus, which inserts a separator as header for tasks grouped by Todo List).
"
Class {
	#name : #CrTaskPresenterCollector,
	#superclass : #CrListVisitor,
	#instVars : [
		'owner',
		'tasks'
	],
	#category : #'Crono-View-Todo-Utils'
}

{ #category : #'private factory' }
CrTaskPresenterCollector >> newHeaderPresenter: aList [

	^ self owner 
		instantiate: CrTodoListHeaderPanel 
		on: aList
]

{ #category : #'private factory' }
CrTaskPresenterCollector >> newTaskPresenter: aTask list: aList [

	^ self owner
		instantiate: CrTodoListTaskSummaryPanel 
		on: (CrTodoListAndTaskPair
			newList: aList
			task: aTask)
]

{ #category : #'private factory' }
CrTaskPresenterCollector >> newTaskPresenters: aCollection list: aList [
 
	^ aCollection collect: [ :each | 
		self newTaskPresenter: each list: aList ]
]

{ #category : #accessing }
CrTaskPresenterCollector >> owner [
	^ owner
]

{ #category : #accessing }
CrTaskPresenterCollector >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
CrTaskPresenterCollector >> tasks [
	^ tasks
]

{ #category : #accessing }
CrTaskPresenterCollector >> tasks: anObject [
	tasks := anObject
]

{ #category : #visiting }
CrTaskPresenterCollector >> visitFocusList: aList [

	^ OrderedCollection streamContents: [ :stream |
		((self tasks 
			sorted: [ :a | a owner isUser ] ascending, [ :a | a owner name ] ascending)
			groupedBy: [ :each | each owner ])
			keysAndValuesDo: [ :list :listTasks |
				stream nextPut: (self newHeaderPresenter: list).
				stream nextPutAll: (self newTaskPresenters: listTasks list: aList) ] ]
]

{ #category : #visiting }
CrTaskPresenterCollector >> visitGenericList: aList [

	^ self
		newTaskPresenters: self tasks 
		list: aList
]
