"
I'm a small tool to keep a daily log. 
I don't know if I will be useful, but Esteban sometimes wants to keep track of all stupid actions he does, without needing to publish them each time (ideally, he will be publishing a digest of this, using WorkLog).

So far, I just know ==#log:==, which appends an entry to the daily log.
"
Class {
	#name : #CrCrono,
	#superclass : #Object,
	#classVars : [
		'ActiveClass'
	],
	#category : #'Crono-Model'
}

{ #category : #accessing }
CrCrono class >> activeClass [

	^ ActiveClass ifNil: [ 
		self useCronoLite.
		ActiveClass ]
]

{ #category : #accessing }
CrCrono class >> activeClass: aClass [

	ActiveClass := aClass
]

{ #category : #'command line' }
CrCrono class >> commandLine [
	<commandline>
	
	^ (ClapCommand withName: 'crono')
		description: 'Manage a crono worklog.';
		add: ClapFlag forHelp;
		add: self commandLineAdd;
		add: self commandLineReview;
		add: self commandLineTodayReference;
		meaning: [ :args | 
			args atName: 'help' ifFound: [ :help | help value; exitSuccess ] ]
]

{ #category : #'command line' }
CrCrono class >> commandLineAdd [

	^ (ClapCommand withName: 'add')
		description: 'Log some work.';
		add: ((ClapPositional withName: 'LOG') 
			description: 'The work to log.';
			multiple: true);
		meaning: [ :args | self new log:  (' ' join: (args occurrencesNamed: 'LOG' collect: #value)) ]
]

{ #category : #'command line' }
CrCrono class >> commandLineReview [

	^ (ClapCommand withName: 'review')
		description: 'Review crono worklog dates.';
		add: ((ClapPositional withName: 'range') implicitMeaning: [ '0' ]);
		meaning: [ :args | self new review: (CrCronoRange fromString: (args atName: 'range') value) ]
]

{ #category : #'command line' }
CrCrono class >> commandLineTodayReference [

	^ (ClapCommand withName: 'todayReference')
		description: 'Prints path of current using file.';
		meaning: [ :args | self new printTodayReference ]
]

{ #category : #'instance creation' }
CrCrono class >> newActive [

	^ self activeClass new
]

{ #category : #accessing }
CrCrono class >> useCronoFile [

	self activeClass: CrCronoFile
]

{ #category : #accessing }
CrCrono class >> useCronoLite [

	self activeClass: CrCronoLite
]

{ #category : #actions }
CrCrono >> log: aString [

	self subclassResponsibility
]

{ #category : #actions }
CrCrono >> review: daysRange [

	self 
		review: daysRange 
		to: self stdout
]

{ #category : #actions }
CrCrono >> review: daysRange to: stream [

	self subclassResponsibility
]

{ #category : #accessing }
CrCrono >> stdout [ 

	^ ZnNewLineWriterStream on: Stdio stdout
]
