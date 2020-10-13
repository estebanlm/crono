Class {
	#name : #CrTodoAddListCommand,
	#superclass : #CrCommand,
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoAddListCommand class >> defaultDescription [

	^ 'Add a new user list.'
]

{ #category : #default }
CrTodoAddListCommand class >> defaultIconName [

	^ 'gtk-add'
]

{ #category : #default }
CrTodoAddListCommand class >> defaultName [

	^ 'New List'
]

{ #category : #default }
CrTodoAddListCommand class >> defaultShortcut [

	^ $n shift platformMeta
]

{ #category : #executing }
CrTodoAddListCommand >> execute [
	| dialog list |
	
	dialog := CrRequestDialog new
		title: 'New List';
		label: 'Please enter your list name';
		openDialogWithSpecParent: context window.
	
	dialog isOk ifFalse: [ ^ self ].
	dialog presenter text isEmptyOrNil ifTrue: [ ^ self ].
	
	list := CrTodoList newName: dialog presenter text.
	list save.
	
	self notificationCenter notify: (CrListAddedNotification newList: list)
]
