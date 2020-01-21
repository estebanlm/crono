Class {
	#name : #CrTodoListTest,
	#superclass : #CrTestCase,
	#category : #'Crono-Tests'
}

{ #category : #tests }
CrTodoListTest >> testArchive [
	| list task |

	task := CrTodoTask new
		name: 'Test';
		notes: 'Test';
		done: false;
		yourself.

	list := CrTodoList newName: 'Test List'. 
	list save.
	list saveTask: task.
	
	self deny: list isArchived.
	self deny: task isArchived.
	
	list archive.
	
	self assert: list isArchived.
	self assert: task isArchived
]

{ #category : #tests }
CrTodoListTest >> testMoveTaskTo [
	| task list1 list2 |

	task := CrTodoTask new
		name: 'Test';
		notes: 'Test';
		done: false;
		yourself.

	list1 := CrTodoList newName: 'List 1'.
	list1 save.
	list2 := CrTodoList newName: 'List 2'.
	list2 save.
	
	list1 saveTask: task.
	self assert: task owner equals: list1.
	
	list1 moveTask: task to: list2.
		
	self assert: list1 tasks isEmpty.
	self assert: list2 tasks anyOne equals: task.
	self assert: CrTodoTask selectAll anyOne equals: task.
	self assert: task owner equals: list2
]

{ #category : #tests }
CrTodoListTest >> testSaveTask [
	| task |

	task := CrTodoTask new
		name: 'Test';
		notes: 'Test';
		done: false;
		yourself.

	(CrTodoList newName: 'Test List') saveTask: task.
		
	self 
		assert: CrTodoTask selectAll anyOne 
		equals: task.
	self 
		assert: (CrTodoList listNamed: 'Test List') tasks anyOne 
		equals: task
]

{ #category : #tests }
CrTodoListTest >> testUnarchive [
	| list task |

	task := CrTodoTask new
		name: 'Test';
		notes: 'Test';
		done: false;
		yourself.

	list := CrTodoList newName: 'Test List'. 
	list save.
	list saveTask: task.

	list archive.	
	
	self assert: list isArchived.
	self assert: task isArchived.
	
	list unarchive. 
	
	self deny: list isArchived.
	self deny: task isArchived
]
