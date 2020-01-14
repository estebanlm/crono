"
I'm a list type archive.
"
Class {
	#name : #CrTodoTypeArchive,
	#superclass : #CrTodoType,
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrTodoTypeArchive >> defaultIconName [

	^ #trash
]

{ #category : #testing }
CrTodoTypeArchive >> isVisible [

	^ false
]

{ #category : #accessing }
CrTodoTypeArchive >> name [
	
	^ 'Archive'
]

{ #category : #testing }
CrTodoTypeArchive >> showsCompletion [

	^ false
]

{ #category : #accessing }
CrTodoTypeArchive >> typeName [

	^ #archive
]
