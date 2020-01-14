Class {
	#name : #CrTodoListIndexPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'actionBar',
		'inactiveList'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListIndexPanel class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #list;
		add: #inactiveList expand: false;
		add: #actionBar expand: false;
		yourself
]

{ #category : #actions }
CrTodoListIndexPanel >> addList [

	(CrTodoAddListCommand forSpecContext: self) execute
]

{ #category : #private }
CrTodoListIndexPanel >> allInactiveListPresenters [
		
	^ self allInactiveLists collect: [ :each | 
		self instantiate: CrTodoListIndexSummaryPanel on: each  ]
]

{ #category : #accessing }
CrTodoListIndexPanel >> allInactiveLists [

	^ CrTodoList allLists reject: #isVisible
]

{ #category : #private }
CrTodoListIndexPanel >> allListPresenters [
		
	^ self allLists collect: [ :each | 
		self instantiate: CrTodoListIndexSummaryPanel on: each  ]
]

{ #category : #accessing }
CrTodoListIndexPanel >> allLists [

	^ CrTodoList allLists select: #isVisible
]

{ #category : #initialization }
CrTodoListIndexPanel >> defineInputPorts [

	^ list defineInputPorts
		collect: [ :each |
			each copy 
				delegateTo: [ list ];
				yourself ]
]

{ #category : #initialization }
CrTodoListIndexPanel >> defineOutputPorts [ 

	^ (list defineOutputPorts 
		collect: [ :each |
			each copy 
				delegateTo: [ list ];
				yourself ]),
		(inactiveList defineOutputPorts
			collect: [ :each | 
				each copy 
					name: 'inactive-', each name;
					delegateTo: [ inactiveList ];
					yourself ])
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

{ #category : #initialization }
CrTodoListIndexPanel >> initialize [

	super initialize.
	self initializeSubscribers
]

{ #category : #initialization }
CrTodoListIndexPanel >> initializePresenters [

	list := self newComponentList
		addStyle: 'list';
		presenters: self allListPresenters;
		selectIndex: 2;
		whenActivatedDo: [ self editList ];
		yourself.
		
	inactiveList := self newComponentList
		addStyle: 'list';
		presenters: self allInactiveListPresenters;
		yourself.
		
	list transmitDo: [ 
		inactiveList selection unselectAll ].
		
	actionBar := self newActionBar
		add: (self newButton 
			"label: 'New List';"
			icon: (self application iconNamed: #actionAdd);
			help: 'Add a new List';
			action: [ self addList ];
			yourself);
		yourself
]

{ #category : #initialization }
CrTodoListIndexPanel >> initializeSubscribers [

	self application notificationCenter
		subscribe: self to: CrListNotification
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

{ #category : #accessing }
CrTodoListIndexPanel >> refresh [

	self refreshThenSelect: self selectedItem
]

{ #category : #accessing }
CrTodoListIndexPanel >> refreshSelection [

	self selectedItem ifNotNil: #refresh
]

{ #category : #accessing }
CrTodoListIndexPanel >> refreshThenSelect: aTodoList [

	list presenters: self allListPresenters.
	self selectItem: aTodoList
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
