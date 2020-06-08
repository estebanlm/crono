Class {
	#name : #CrListVisitor,
	#superclass : #Object,
	#category : #'Crono-Model-Todo'
}

{ #category : #'as yet unclassified' }
CrListVisitor >> visit: aList [ 
	
	^ aList accept: self
]

{ #category : #visiting }
CrListVisitor >> visitArchiveList: aList [

	^ self visitGenericList: aList
]

{ #category : #visiting }
CrListVisitor >> visitFocusList: aList [

	^ self visitGenericList: aList
]

{ #category : #visiting }
CrListVisitor >> visitGenericList: aList [

	^ nil
]

{ #category : #visiting }
CrListVisitor >> visitSearchList: aList [

	^ self visitGenericList: aList
]

{ #category : #visiting }
CrListVisitor >> visitTodoList: aList [

	^ self visitGenericList: aList
]

{ #category : #visiting }
CrListVisitor >> visitVirtualList: aList [

	^ self visitGenericList: aList
]
