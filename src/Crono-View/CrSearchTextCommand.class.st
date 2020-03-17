Class {
	#name : #CrSearchTextCommand,
	#superclass : #CrCommand,
	#instVars : [
		'searchText'
	],
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #executing }
CrSearchTextCommand >> execute [
	
	CrTodoList search searchText: self searchText.
	self notificationCenter notify: CrSearchChangedNotification new
]

{ #category : #accessing }
CrSearchTextCommand >> searchText [

	^ searchText
]

{ #category : #accessing }
CrSearchTextCommand >> searchText: aString [

	searchText := aString
]
