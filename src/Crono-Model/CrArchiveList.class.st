"
I am a virtual list that will answer archived tasks.
"
Class {
	#name : #CrArchiveList,
	#superclass : #CrVirtualList,
	#category : #'Crono-Model-Todo'
}

{ #category : #visiting }
CrArchiveList >> accept: aVisitor [

	^ aVisitor visitArchiveList: self
]

{ #category : #accessing }
CrArchiveList >> summaryString [

	^ ''
]

{ #category : #accessing }
CrArchiveList >> tasks [

	self flag: #TODO.
	^ #()
]

{ #category : #accessing }
CrArchiveList >> type [

	^ CrTodoType trash
]
