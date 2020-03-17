"
I am a panel to show the list of todo lists. 

"
Class {
	#name : #CrTodoListIndexPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'actionBar',
		'inactiveList',
		'showArchivedButton',
		'shownArchived'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListIndexPanel class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #list;
		"add: #inactiveList expand: false;"
		add: #actionBar expand: false;
		yourself
]

{ #category : #accessing }
CrTodoListIndexPanel >> activeLists [

	^ CrTodoList activeLists
]

{ #category : #accessing }
CrTodoListIndexPanel >> activeTodoList [
	
	list ifNil: [ ^ nil ].
	^ self selectedItem ifNotNil: #todoList
]

{ #category : #actions }
CrTodoListIndexPanel >> addList [

	(CrTodoAddListCommand forSpecContext: self) execute
]

{ #category : #'private actions' }
CrTodoListIndexPanel >> addSearchPanel [

	list presenters first todoList = CrTodoList search 
		ifFalse: [ 
			list presenters: (list presenters copyWithFirst: (self newPanelFor: CrTodoList search)) ].
	self selectItem: CrTodoList search
]

{ #category : #private }
CrTodoListIndexPanel >> contextMenu [

	^ self contextMenuActions 
		prepareForContextMenu;
		asMenuPresenter
]

{ #category : #private }
CrTodoListIndexPanel >> contextMenuActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'Organisation') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoAddListCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Management') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoViewArchivedCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Critical') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoListArchiveCommand forSpecContext: self);
			register: (CrTodoListDeleteCommand forSpecContext: self);
			yourself);
		yourself
]

{ #category : #private }
CrTodoListIndexPanel >> contextMenuKeyBindings [

	^ self contextMenuActions asKMCategory
]

{ #category : #initialization }
CrTodoListIndexPanel >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : #initialization }
CrTodoListIndexPanel >> defineInputPorts [

	^ list defineInputPorts
		collect: [ :each |
			each copy 
				delegateTo: [ list ];
				yourself ]
]

{ #category : #'private actions' }
CrTodoListIndexPanel >> doToggleShownArchived [

	shownArchived := shownArchived not.
	self refresh
]

{ #category : #actions }
CrTodoListIndexPanel >> editList [
	| todoList |

	todoList := self selectedItem todoList.
	todoList isEditable ifFalse: [ ^ self ].

	(CrTodoEditListCommand forContext: self) 
		list: todoList;
		execute
]

{ #category : #accessing }
CrTodoListIndexPanel >> firstResponder [

	^ list
]

{ #category : #accessing }
CrTodoListIndexPanel >> inactiveLists [

	^ CrTodoList archivedLists
]

{ #category : #initialization }
CrTodoListIndexPanel >> initialize [

	shownArchived := false.
	super initialize.
	self initializeSubscribers
]

{ #category : #initialization }
CrTodoListIndexPanel >> initializePresenters [

	list := self newComponentList
		addStyle: 'list';
		presenters: self visibleListPresenters;
		selectIndex: 2;
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		whenActivatedDo: [ self editList ];
		yourself.
		
	"inactiveList := self newComponentList
		addStyle: 'list';
		presenters: self allInactiveListPresenters;
		yourself.
		
	list transmitDo: [ 
		inactiveList selection unselectAll ]."
		
	actionBar := self newActionBar
		add: (self newButton 
			"label: 'New List';"
			icon: (self application iconNamed: #actionAdd);
			help: 'Add a new List';
			action: [ self addList ];
			yourself);
		addLast: ((showArchivedButton := self newToggleButton)
			icon: (self application iconNamed: #actionShow);
			help: 'Show archived lists';
			whenChangedDo: [ self doToggleShownArchived ];
			yourself);
		yourself
]

{ #category : #initialization }
CrTodoListIndexPanel >> initializeSubscribers [

	self application notificationCenter
		subscribe: self to: CrListNotification;
		subscribe: self to: CrSearchChangedNotification
]

{ #category : #'private factory' }
CrTodoListIndexPanel >> newPanelFor: aTodoList [

	^ self instantiate: CrTodoListIndexSummaryPanel on: aTodoList
]

{ #category : #'notification handling' }
CrTodoListIndexPanel >> noteList: aNotification [

	self refreshThenSelect: aNotification list
]

{ #category : #'notification handling' }
CrTodoListIndexPanel >> noteListChanged: aNotification [
	
	"notification can be applied to more than one list (in case of virtual list
	 operations)"
	list items 
		select: [ :each | aNotification appliesToList: each todoList ]
		thenDo: [ :each | each refresh ]
]

{ #category : #'notification handling' }
CrTodoListIndexPanel >> noteSearchChanged: aNotification [
	
	self toggleSearchPanel
]

{ #category : #initialization }
CrTodoListIndexPanel >> outputSelectionPort [
	
	^ (SpSelectionPort newPresenter: self)
		delegateTo: [ list ];
		yourself
]

{ #category : #accessing }
CrTodoListIndexPanel >> refresh [

	self refreshThenSelect: self selectedItem todoList
]

{ #category : #accessing }
CrTodoListIndexPanel >> refreshSelection [

	self selectedItem ifNotNil: #refresh
]

{ #category : #accessing }
CrTodoListIndexPanel >> refreshThenSelect: aTodoList [

	list presenters: self visibleListPresenters.
	self selectItem: aTodoList
]

{ #category : #'private actions' }
CrTodoListIndexPanel >> removeSearchPanel [
	| shouldSelectFocus |

	shouldSelectFocus := self activeTodoList = CrTodoList search.
	list presenters first todoList = CrTodoList search 
		ifTrue: [ list presenters: list presenters allButFirst ].
	shouldSelectFocus ifTrue: [ 
		self selectItem: CrTodoList focus ]
]

{ #category : #accessing }
CrTodoListIndexPanel >> selectItem: aTodoList [

	self flag: #TODO. "This is identical to CrTodoListPanel>>selectItem:, we need to 
	find a way to unify them "
	list items 
		detect: [ :each | each todoList = aTodoList ]
		ifFound: [ :each | list selectItem: each ]
		ifNone: [ list unselectAll ]
]

{ #category : #accessing }
CrTodoListIndexPanel >> selectedItem [

	^ list selection selectedItem
]

{ #category : #testing }
CrTodoListIndexPanel >> shownArchived [

	^ shownArchived
]

{ #category : #actions }
CrTodoListIndexPanel >> toggleSearchPanel [

	CrTodoList search hasElements
		ifTrue: [ self addSearchPanel ]
		ifFalse: [ self removeSearchPanel ]
]

{ #category : #actions }
CrTodoListIndexPanel >> toggleShownArchived [

	showArchivedButton state: showArchivedButton state not
]

{ #category : #private }
CrTodoListIndexPanel >> visibleListPresenters [
		
	^ self visibleLists collect: [ :each | self newPanelFor: each ]
]

{ #category : #accessing }
CrTodoListIndexPanel >> visibleLists [

	self shownArchived ifFalse: [ ^ self activeLists ].
	^ self activeLists, self inactiveLists
]
