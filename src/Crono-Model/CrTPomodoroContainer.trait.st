"
I define the behavior to implement pomodoro tasks into another task.
"
Trait {
	#name : #CrTPomodoroContainer,
	#instVars : [
		'pomodoroTasks'
	],
	#category : #'Crono-Model-Pomodoro'
}

{ #category : #persistence }
CrTPomodoroContainer classSide >> voyagePomodoroTasks [
	<voyageDescription>
	
	^ VOToOneDescription new 
		attributeName: 'pomodoroTasks';
		accessor: (MAPluggableAccessor 
			read: [ :aTask | aTask pomodoroTasks ]
			write: [ :aTask :pomodoroTasks | 
				pomodoroTasks ifNotNil: [ aTask setPomodoroTasks: pomodoroTasks ] ]);
		yourself
]

{ #category : #accessing }
CrTPomodoroContainer >> addPomodoroTask: aPomodoroTask [

	pomodoroTasks ifNil: [ pomodoroTasks := OrderedCollection new ].
	pomodoroTasks add: aPomodoroTask.
	self save
]

{ #category : #testing }
CrTPomodoroContainer >> hasPomodoroTasks [

	^ pomodoroTasks notNil and: [ pomodoroTasks notEmpty ]
]

{ #category : #factory }
CrTPomodoroContainer >> newPomodoroTask [

	^ CrPomodoroTask newTask: self
]

{ #category : #accessing }
CrTPomodoroContainer >> pomodoroName [

	^ self required
]

{ #category : #accessing }
CrTPomodoroContainer >> pomodoroTasks [

	^ pomodoroTasks	
]

{ #category : #initialization }
CrTPomodoroContainer >> setPomodoroTasks: aCollection [

	aCollection do: [ :each | each ownerTask: self ].
	pomodoroTasks := aCollection
]
