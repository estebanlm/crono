"
I keep the configuration for crono. 
I'm saved in a file ""crono.ston"" who should be placed at the side of the image who contains the application.
Since we are doing a stateless command line application, there is no problem on reading the configuration file each time we perform a task, because of this, the entry-point of this class is #readFromFileSystem (and not #new)

Take a look at #sample method to hints on config structure.
"
Class {
	#name : #CrCronoConfiguration,
	#superclass : #CrConfiguration,
	#instVars : [
		'baseDir'
	],
	#category : #'Crono-Model-Crono'
}

{ #category : #accessing }
CrCronoConfiguration class >> fileName [

	^ 'crono.ston'
]

{ #category : #'instance creation' }
CrCronoConfiguration class >> sample [
	"
	self configFileName asFileReference 
		writeStreamDo: [ :stream | STON put: self sample onStreamPretty: stream ]
	"
	^ self new 
		baseDir: '{home}/Dev/CronoLog';
		yourself
]

{ #category : #accessing }
CrCronoConfiguration class >> stonName [
	^ #Crono
]

{ #category : #accessing }
CrCronoConfiguration >> baseDir [
	^ baseDir
]

{ #category : #accessing }
CrCronoConfiguration >> baseDir: anObject [
	"baseDir is a directory to the place where crono logs will be stored"
	baseDir := anObject
]

{ #category : #accessing }
CrCronoConfiguration >> baseDirReference [
	"I will interpret #baseDir to allow users to declare FileLocator positions (just in first 
	 segment of path). 
	 e.g. I can intepret {home}/Dev/CronoLog"
	^ self baseDir first = ${
		ifTrue: [ self baseDirReferenceWithLocator ]
		ifFalse: [ self baseDir asFileReference ]
	
]

{ #category : #private }
CrCronoConfiguration >> baseDirReferenceWithLocator [
	"I interpret first entry as a location: {home}, {desktop}, {preferences}, etc. 
	 (See FileLocator class for others)"
	| segments location |
	segments := self baseDir substrings: (DiskStore delimiter) asString.
	location := (segments first copyFrom: 2 to: (segments first size - 1)) asSymbol. 
	^ segments allButFirst 
		inject: (FileLocator origin: location) asFileReference
		into: [ :all :each | all / each ]
]

{ #category : #accessing }
CrCronoConfiguration >> logReference [

	^ (self baseDirReference / 'Logs') ensureCreateDirectory
]

{ #category : #accessing }
CrCronoConfiguration >> todoListReference [

	^ (self baseDirReference / 'ToDo') ensureCreateDirectory
]
