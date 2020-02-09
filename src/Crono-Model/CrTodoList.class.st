"
I'm a user defined lists. 
Of course, this is the most important list we can have since is the one that keep usert tasks.


"
Class {
	#name : #CrTodoList,
	#superclass : #CrAbstractList,
	#instVars : [
		'type',
		'name',
		'iconName',
		'tasks',
		'archived'
	],
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoList class >> allLists [
	
	^ self baseLists, self userLists
]

{ #category : #accessing }
CrTodoList class >> baseLists [

	"This is just an easy way to keep cached the base objects to avoid making a select each time
	 (which can be time consuming, just to bring some lists we already know are there).
	 Yes it is a HACK :P"
	^ CrApplication current 
		propertyAt: #baseLists 
		ifAbsentPut: [ { self inbox. self focus. self unsorted. self life } ]
]

{ #category : #accessing }
CrTodoList class >> focus [

	^ CrFocusList uniqueInstance
]

{ #category : #accessing }
CrTodoList class >> inbox [

	^ CrApplication current 
		propertyAt: #inbox 
		ifAbsentPut: [ self selectOne: [ :each | each type = CrTodoType inbox typeName ] ]
]

{ #category : #testing }
CrTodoList class >> isVoyageRoot [

	^ true
]

{ #category : #accessing }
CrTodoList class >> life [

	^ self selectOne: [ :each | each type = CrTodoType life typeName ]
]

{ #category : #accessing }
CrTodoList class >> listNamed: aString [
	
	^ self selectOne: [ :each | each name = aString ]
]

{ #category : #accessing }
CrTodoList class >> lists [
	
	^ self allLists reject: #isVirtual
]

{ #category : #private }
CrTodoList class >> newBaseLists [
	
	^ { 
		(CrTodoList newType: CrTodoType inbox).
		(CrTodoList newType: CrTodoType unsorted).
		(CrTodoList newType: CrTodoType life)
	}
]

{ #category : #'instance creation' }
CrTodoList class >> newName: aString [

	^ (self newType: CrTodoType user) 
		name: aString;
		yourself
]

{ #category : #'instance creation' }
CrTodoList class >> newType: aListType [

	^ self basicNew
		initializeType: aListType;
		yourself
]

{ #category : #accessing }
CrTodoList class >> summaryString [

	^ '{1} pending task{2} ({3} completed).'
]

{ #category : #accessing }
CrTodoList class >> trash [

	^ CrArchiveList uniqueInstance
]

{ #category : #accessing }
CrTodoList class >> unsorted [

	^ self selectOne: [ :each | each type = CrTodoType unsorted typeName ]
]

{ #category : #accessing }
CrTodoList class >> userLists [
	
	^ self selectMany: [ :each | each type = CrTodoType user typeName ]
]

{ #category : #persistence }
CrTodoList class >> voyageCollectionName [

	^ 'lists'
]

{ #category : #persistence }
CrTodoList class >> voyageRepository [

	^ CrModelApplication current repository
]

{ #category : #persistence }
CrTodoList class >> voyageType [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'type';
		accessor: (MAPluggableAccessor 
			read: [ :aList | aList type typeName ]
			write: [ :aList :typeName | aList setType: (CrTodoType perform: typeName asSymbol) ]);
		yourself
]

{ #category : #accessing }
CrTodoList >> addTask: aTask [

	aTask owner: self.
	tasks add: aTask
]

{ #category : #actions }
CrTodoList >> archive [

	self isArchived ifTrue: [ ^ self ].

	self archived: true.
	self save
]

{ #category : #accessing }
CrTodoList >> archived: aBoolean [

	archived := aBoolean
]

{ #category : #accessing }
CrTodoList >> completion [

	self tasksSize = 0 ifTrue: [ ^ 0 ].  
	^ self doneTasksSize / self tasksSize
]

{ #category : #accessing }
CrTodoList >> iconName [

	^ iconName ifNil: [ super iconName ]
]

{ #category : #accessing }
CrTodoList >> iconName: aSymbol [

	iconName := aSymbol
]

{ #category : #initialization }
CrTodoList >> initialize [

	super initialize.
	archived := false.
	tasks := OrderedCollection new
]

{ #category : #initialization }
CrTodoList >> initializeType: aType [

	self initialize.
	self setType: aType
]

{ #category : #accessing }
CrTodoList >> isArchived [

	^ archived
]

{ #category : #actions }
CrTodoList >> moveTask: aTask to: aTodoList [

	(self includesTask: aTask) ifFalse: [ 
		^ self error: 'Task does not belong to this list' ].
	
	aTodoList receiveTask: aTask from: self
]

{ #category : #accessing }
CrTodoList >> name [

	^ name ifNil: [ self type defaultName ]
]

{ #category : #accessing }
CrTodoList >> name: aString [

	name := aString
]

{ #category : #printing }
CrTodoList >> printOn: stream [

	super printOn: stream.
	stream << '(' << self name << ')'
]

{ #category : #'private actions' }
CrTodoList >> receiveTask: aTask from: aTodoList [

	self class voyageRepository commit: [ 
		"remove task from previous list"
		aTodoList 
			removeTask: aTask 
			follow: false.
		"add the task as a regular task"
		self saveTask: aTask.
		"ensure task is saved with changes"
		aTask save ]
]

{ #category : #persistence }
CrTodoList >> remove [

	self class voyageRepository commit: [ 
		self tasks copy do: [ :each | 
			self removeTask: each.
			each remove ].
		super remove ]
]

{ #category : #accessing }
CrTodoList >> removeAllTasks [
	
	tasks := Array new
]

{ #category : #accessing }
CrTodoList >> removeTask: aTask [

	aTask owner: nil.
	^ self tasks remove: aTask
]

{ #category : #actions }
CrTodoList >> removeTask: aTask follow: follow [

	(self includesTask: aTask) ifFalse: [ 
		self error: 'Task does not belong to this list.' ].

	self class voyageRepository commit: [  
		self removeTask: aTask.
		self save.
		follow ifTrue: [ aTask remove ] ].
]

{ #category : #actions }
CrTodoList >> saveTask: aTask [

	self addTask: aTask.
	self save
]

{ #category : #private }
CrTodoList >> setType: aType [

	type := aType
]

{ #category : #accessing }
CrTodoList >> tasks [

	^ tasks
]

{ #category : #accessing }
CrTodoList >> tasks: aCollection [

	tasks := aCollection asOrderedCollection
]

{ #category : #actions }
CrTodoList >> toggleArchive [

	self isArchived 
		ifTrue: [ self unarchive ]
		ifFalse: [ self archive ]
]

{ #category : #accessing }
CrTodoList >> type [

	^ type
]

{ #category : #accessing }
CrTodoList >> type: aListType [

	type := aListType
]

{ #category : #actions }
CrTodoList >> unarchive [

	self isArchived ifFalse: [ ^ self ].
	self archived: false.
	self save
]

{ #category : #writing }
CrTodoList >> writeToFile [
	| reference |

	reference := (self class todoListReference / self name) withExtension: 'ston'.
	reference writeStreamDo: [ :stream | 
		STON put: self onStreamPretty: stream ]
]
