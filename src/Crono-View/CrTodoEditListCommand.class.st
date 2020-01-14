"
I am a edit list command.
"
Class {
	#name : #CrTodoEditListCommand,
	#superclass : #CrCommand,
	#instVars : [
		'list'
	],
	#category : #'Crono-View-Todo-Commands'
}

{ #category : #default }
CrTodoEditListCommand class >> defaultDescription [

	^ 'Edit an user list.'
]

{ #category : #default }
CrTodoEditListCommand class >> defaultName [

	^ 'Edit List'
]

{ #category : #executing }
CrTodoEditListCommand >> execute [
	| dialog |
	
	dialog := CrRequestDialog new
		title: ('Rename {1}' format: { list name });
		label: 'Please enter your list name';
		openDialogWithSpecParent: context window.
	
	dialog isOk ifFalse: [ ^ self ].
	dialog presenter text isEmptyOrNil ifTrue: [ ^ self ].
	
	list name: dialog presenter text.
	list save.
	
	context application notificationCenter notify: (CrListChangedNotification newList: list)

]

{ #category : #accessing }
CrTodoEditListCommand >> list [
	^ list
]

{ #category : #accessing }
CrTodoEditListCommand >> list: anObject [
	list := anObject
]
