Class {
	#name : #CrListNotification,
	#superclass : #CrNotification,
	#instVars : [
		'list'
	],
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #'instance creation' }
CrListNotification class >> newList: aTodoList [

	^ self new list: aTodoList
]

{ #category : #accessing }
CrListNotification class >> receiverSelector [

	^ #noteList:
]

{ #category : #testing }
CrListNotification >> appliesToList: aTodoList [

	^ self list = aTodoList
]

{ #category : #accessing }
CrListNotification >> list [
	^ list
]

{ #category : #accessing }
CrListNotification >> list: anObject [
	list := anObject
]
