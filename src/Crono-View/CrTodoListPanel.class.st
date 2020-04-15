"
I am a panel to show a list of tasks.

"
Class {
	#name : #CrTodoListPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'statusBar',
		'actionBar',
		'todoList',
		'shownArchived',
		'showArchivedButton'
	],
	#category : #'Crono-View-Todo'
}

{ #category : #specs }
CrTodoListPanel class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #list;
		add: #actionBar expand: false;
		yourself
]

{ #category : #accessing }
CrTodoListPanel >> activeTask [

	^ list selection selectedItem ifNotNil: #task
]

{ #category : #accessing }
CrTodoListPanel >> activeTodoList [

	^ self todoList
]

{ #category : #initialization }
CrTodoListPanel >> addGlobalShortcutsTo: aWindowPresenter [

	aWindowPresenter 
		bindKey: $n 
		toAction: [ self addTask ]
]

{ #category : #actions }
CrTodoListPanel >> addTask [

	(CrTodoAddTaskCommand forContext: self) execute
]

{ #category : #actions }
CrTodoListPanel >> archiveCompletedTasks [

	(CrTodoArchiveCompletedCommand forContext: self) execute
]

{ #category : #private }
CrTodoListPanel >> autoArchiveAfterDays [

	^ self application settings autoArchiveAfterDays
]

{ #category : #private }
CrTodoListPanel >> contextMenu [

	^ self contextMenuActions 
		prepareForContextMenu;
		asMenuPresenter
]

{ #category : #private }
CrTodoListPanel >> contextMenuActions [

	^ CmCommandGroup forSpec
		beRoot;
		register: ((CmCommandGroup named: 'Organisation') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoTaskToggleFocusCommand forSpecContext: self);
			register: (CrTodoAddTaskCommand forSpecContext: self);
			register: (CrTodoTaskMoveCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Pomodoro') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoTaskStartPomodoroCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Management') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoViewArchivedCommand forSpecContext: self);
			yourself);
		register: ((CmCommandGroup named: 'Critical') asSpecGroup
			beDisplayedAsGroup;
			register: (CrTodoArchiveCompletedCommand forSpecContext: self);
			register: (CrTodoTaskArchiveCommand forSpecContext: self);
			register: (CrTodoTaskDeleteCommand forSpecContext: self);
			yourself);
		yourself
]

{ #category : #private }
CrTodoListPanel >> contextMenuKeyBindings [

	^ self contextMenuActions asKMCategory
]

{ #category : #ports }
CrTodoListPanel >> defaultInputPort [
	
	^ self inputModelPort
]

{ #category : #'private actions' }
CrTodoListPanel >> doToggleShownArchived [

	shownArchived := shownArchived not.
	self refresh
]

{ #category : #actions }
CrTodoListPanel >> editTask [

	(CrTodoEditTaskCommand forContext: self) execute
]

{ #category : #accessing }
CrTodoListPanel >> firstResponder [

	^ list
]

{ #category : #initialization }
CrTodoListPanel >> initialize [

	shownArchived := false.
	super initialize.
	self initializeSubscribers.

]

{ #category : #initialization }
CrTodoListPanel >> initializePresenters [

	(list := self newComponentList)
		addStyle: 'list';
		contextMenu: [ self contextMenu ];
		contextKeyBindings: self contextMenuKeyBindings;
		bindKeyCombination: Character space asKeyCombination 
			toAction: [ self selectedItemToggleState ];
		whenActivatedDo: [ self editTask ].
		
	actionBar := self newActionBar
		add: (statusBar := self instantiate: CrTodoListStatusBarPanel);
		addLast: ((showArchivedButton := self newToggleButton)
			icon: (self application iconNamed: #actionShow);
			help: 'Show archived tasks';
			whenChangedDo: [ self doToggleShownArchived ];
			yourself);
		addLast: (self newButton
			icon: (self application iconNamed: #actionTrash);
			help: 'Archive completed tasks now';
			action: [ self archiveCompletedTasks ];
			yourself);
		yourself
]

{ #category : #initialization }
CrTodoListPanel >> initializeSubscribers [

	self application notificationCenter 
		subscribe: self to: CrTaskNotification;
		subscribe: self to: CrListChangedNotification
]

{ #category : #ports }
CrTodoListPanel >> inputModelPort [
	
	^ SpModelPort newPresenter: self
]

{ #category : #'private factory' }
CrTodoListPanel >> newTaskPresenters [
	
	^ self todoList tasks
		collect: [ :each | 
			self 
				instantiate: CrTodoListTaskSummaryPanel 
				on: (CrTodoListAndTaskPair
					newList: self todoList 
					task: each) ]
]

{ #category : #'private factory' }
CrTodoListPanel >> newTaskPresentersFor: aCollection [
	
	^ aCollection collect: [ :each | 
		self 
			instantiate: CrTodoListTaskSummaryPanel 
			on: (CrTodoListAndTaskPair
				newList: self todoList 
				task: each) ]
]

{ #category : #'notification handling' }
CrTodoListPanel >> noteListChanged: aNotification [

	(aNotification appliesToList: self todoList) ifFalse: [ ^ self ].
	self refresh
]

{ #category : #'notification handling' }
CrTodoListPanel >> noteTaskAdded: aNotification [

	(self todoList includesTask: aNotification task) ifFalse: [ ^ self ].
	
	list items: self newTaskPresenters.
	self selectItem: aNotification task.
	list takeKeyboardFocus
]

{ #category : #'notification handling' }
CrTodoListPanel >> noteTaskChanged: aNotification [
	"Someone changed this list from another place"

	list presenters
		detect: [ :each | each task = aNotification task ]
		ifFound: [ :aPresenter | 
			aPresenter refreshContentIfNeeded.
			statusBar refresh ].

	
]

{ #category : #'notification handling' }
CrTodoListPanel >> noteVirtualListTaskChanged: aNotification [
	"do not refresh if task in virtial list changed (the change will be impacted differently)"
]

{ #category : #accessing }
CrTodoListPanel >> refresh [
	| selectedItem tasks |

	selectedItem := list selection selectedItem ifNotNil: #task.
	tasks := self visibleTasksInRightOrder.
	list items: (self newTaskPresentersFor: tasks).
	selectedItem ifNotNil: [ 
		self selectItem: selectedItem ].
	statusBar refresh
]

{ #category : #accessing }
CrTodoListPanel >> selectItem: aListItem [

	list items 
		detect: [ :each | each task = aListItem ]
		ifFound: [ :each | list selectItem: each ]
		ifNone: [ list unselectAll ]
]

{ #category : #actions }
CrTodoListPanel >> selectedItemToggleState [

	list selection selectedItem ifNotNil: #toggleState
]

{ #category : #private }
CrTodoListPanel >> setModel: aTodoList [

	self todoList: aTodoList
]

{ #category : #testing }
CrTodoListPanel >> shownArchived [

	^ shownArchived
]

{ #category : #accessing }
CrTodoListPanel >> todoList [

	^ todoList
]

{ #category : #accessing }
CrTodoListPanel >> todoList: aList [

	todoList := aList.
	statusBar todoList: aList.
	self refresh
]

{ #category : #actions }
CrTodoListPanel >> toggleShownArchived [

	showArchivedButton state: showArchivedButton state not
]

{ #category : #private }
CrTodoListPanel >> visibleTasksInRightOrder [
	| tasks |
	
	self todoList archiveCompletedTasksAfterDays: self autoArchiveAfterDays.
	self shownArchived ifFalse: [ ^ self todoList tasks reject: #isArchived ].
	
	tasks := self todoList tasks groupedBy: #isArchived.
	^ (tasks at: false ifAbsent: [ #() ]), 
	  (tasks at: true ifAbsent: [ #() ])
]
