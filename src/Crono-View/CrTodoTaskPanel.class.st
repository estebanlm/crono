"
I am a panel to show an item content.
I can be shown as dialog or as part of another component.

I show a task title, description, completion and maybe other details.
"
Class {
	#name : #CrTodoTaskPanel,
	#superclass : #CrTodoPresenter,
	#instVars : [
		'nameTextInput',
		'notesText',
		'doneCheckbox',
		'todoList',
		'addAction'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoTaskPanel class >> defaultSpec [

	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		borderWidth: 3;
		add: (SpBoxLayout newVertical
				add: #doneCheckbox expand: false fill: false padding: 4;
				yourself)
			expand: false;
		add: (SpBoxLayout newVertical
			spacing: 3;
			add: #nameTextInput expand: false;
			add: #notesText;
			yourself);
		yourself
]

{ #category : #initialization }
CrTodoTaskPanel >> initializePresenters [

	doneCheckbox := self newCheckBox.
	nameTextInput := self newTextInput
		autoAccept: true;
		placeholder: 'A Task name';
		yourself.
	notesText := self newText
		placeholder: 'Notes';
		yourself
]

{ #category : #initialization }
CrTodoTaskPanel >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		initialExtent: 500@150;
		whenOpenedDo: [ nameTextInput takeKeyboardFocus ]
]

{ #category : #accessing }
CrTodoTaskPanel >> todoList [

	^ todoList
]

{ #category : #accessing }
CrTodoTaskPanel >> todoList: aList [

	todoList := aList
]

{ #category : #actions }
CrTodoTaskPanel >> validate [
	
	^ true
]
