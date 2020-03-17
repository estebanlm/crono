"
I'm a window to show all the todo lists, including the inbox and the active lists.
This is more or less like a GTD. 

"
Class {
	#name : #CrTodoWindow,
	#superclass : #CrTodoPresenter,
	#instVars : [
		'indexPanel',
		'listPanel',
		'toolbar',
		'searchField'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoWindow class >> defaultSpec [

	^ SpBoxLayout newVertical 
		add: (SpBoxLayout newHorizontal
				spacing: 5; 
				add: #toolbar;
				addLast: (SpBoxLayout newVertical 
					add: #searchField 
						expand: false 
						fill: false
						padding: 5;
					yourself) 
					expand: false
					fill: false
					padding: 5;
				yourself)
			expand: false; 
		add: (SpPanedLayout newHorizontal
			position: 30 percent;
			add: #indexPanel;
			add: #listPanel;
			yourself);
		yourself
]

{ #category : #accessing }
CrTodoWindow >> activeTask [

	^ listPanel presenter activeTask
]

{ #category : #accessing }
CrTodoWindow >> activeTodoList [

	^ listPanel presenter activeTodoList
]

{ #category : #initialization }
CrTodoWindow >> addGlobalShortcutsTo: aWindowPresenter [

	aWindowPresenter 
		bindKey: $l toAction: [ searchField takeKeyboardFocus ];
		bindKeysWith: self allKeyBindingActions
]

{ #category : #private }
CrTodoWindow >> allKeyBindingActions [

	^ CmCommandGroup forSpec
		register: (CrTodoAddNewCronoCommand forSpecContext: self);
		register: (CrTodoReviewCronoCommand forSpecContext: self);
		register: (CrTodoAddTaskCommand forSpecContext: self);
		register: (CrTodoAddListCommand forSpecContext: self);
		yourself
]

{ #category : #private }
CrTodoWindow >> configurationClass [

	^ CrTodoWindowConfiguration
]

{ #category : #initialization }
CrTodoWindow >> doTransmitList: aTodoList [

	aTodoList ifNil: [ ^ self ].
	listPanel presenter todoList = aTodoList ifTrue: [ ^ self ].

	listPanel presenter todoList: aTodoList.
	self updateListPanel: aTodoList
]

{ #category : #initialization }
CrTodoWindow >> initialize [

	super initialize.
	self initializeSubscribers
]

{ #category : #initialization }
CrTodoWindow >> initializeIndexPanel: aNumber [

	(indexPanel := self instantiate: CrSelectionablePanel)
		panelNumber: aNumber;
		title: 'Lists';
		instantiatePresenter: CrTodoListIndexPanel
	
]

{ #category : #initialization }
CrTodoWindow >> initializeListPanel: aNumber [
	| todoList |
	
	todoList := indexPanel presenter selectedItem todoList.
	(listPanel := self instantiate: CrSelectionablePanel)
		panelNumber: aNumber;
		instantiatePresenter: CrTodoListPanel.
	listPanel presenter todoList: todoList.
	self updateListPanel: todoList.
	
]

{ #category : #initialization }
CrTodoWindow >> initializePresenters [

	self initializeToolbar.	
	self initializeSearchField.
	self initializeIndexPanel: 1.
	self initializeListPanel: 2.
	
	indexPanel presenter 
		transmitDo: [ :aTodoList | self doTransmitList: aTodoList ]
		transform: [ :aSummaryPresenter | aSummaryPresenter ifNotNil: #todoList ].
		
	"indexPanel presenter 
		transmitPort: 'inactive-selection' 
		do: [ :aTodoList | self doTransmitList: aTodoList ]
		transform: [ :aSummaryPresenter | aSummaryPresenter ifNotNil: #todoList ].	"
]

{ #category : #initialization }
CrTodoWindow >> initializeSearchField [

	searchField := self newSearchInput
		autoAccept: true;
		help: 'Search...';
		whenTextChangedDo: [ :text | self searchText: text ];
		yourself
]

{ #category : #initialization }
CrTodoWindow >> initializeSubscribers [

	self application notificationCenter 
		subscribe: self to: CrTaskNotification
]

{ #category : #initialization }
CrTodoWindow >> initializeToolbar [
	
	toolbar := self newToolBar.
	toolbar beIcons.
	toolbar fillWith: self toolbarActions
]

{ #category : #initialization }
CrTodoWindow >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenOpenedDo: [
		indexPanel firstResponder takeKeyboardFocus ]
]

{ #category : #'notification handling' }
CrTodoWindow >> noteTask: aNotification [
 
	"A task has changed. I need to refresh it"
	indexPanel presenter refreshSelection.
	"... and I maybe need to refresh the header"
	self activeTodoList showsCompletion ifFalse: [ ^ self ].
	self updateListPanel: self activeTodoList
]

{ #category : #actions }
CrTodoWindow >> searchText: aString [

	(CrSearchTextCommand forContext: self) 
		searchText: aString;
		execute
]

{ #category : #testing }
CrTodoWindow >> shownArchived [
	
	^ listPanel presenter shownArchived
]

{ #category : #initialization }
CrTodoWindow >> title [ 

	^ 'Lists'
]

{ #category : #private }
CrTodoWindow >> toolbarActions [

	^ CmCommandGroup forSpec
		register: (CrTodoAddNewCronoCommand forSpecContext: self);
		register: (CrTodoAddTaskCommand forSpecContext: self);
		register: (CrTodoReviewCronoCommand forSpecContext: self);
		yourself
]

{ #category : #'private updating' }
CrTodoWindow >> updateListPanel: todoList [
	
	listPanel 
		title: todoList name;
		image: (todoList iconOn: self application)
]
