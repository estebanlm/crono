Class {
	#name : #CrListChangedNotification,
	#superclass : #CrListNotification,
	#category : #'Crono-View-Todo-Notifications'
}

{ #category : #accessing }
CrListChangedNotification class >> receiverSelector [

	^ #noteListChanged:
]

{ #category : #testing }
CrListChangedNotification >> appliesToList: aTodoList [

	^ (super appliesToList: aTodoList)
		or: [ 
			self list isVirtual 
			and: [ self list listForAddTask = aTodoList ] ]
]
