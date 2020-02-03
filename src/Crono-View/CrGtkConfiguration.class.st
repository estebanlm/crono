"
I am a configuration for the Crono application to be used with Gtk backend. 
I define a light theme.
"
Class {
	#name : #CrGtkConfiguration,
	#superclass : #SpGtkConfiguration,
	#instVars : [
		'iconProvider'
	],
	#category : #'Crono-View-Application'
}

{ #category : #'accessing style' }
CrGtkConfiguration >> commonStyle [

	^ '
.title { font-weight: bold }
.titleShortcut { color: LightSlateGrey }
.list { padding: 5px }
.listNameLabel { color: LightSlateGrey; font-size: smaller; margin-right: 3px }
.markFocus { margin-right: 3px }
'
]

{ #category : #configuring }
CrGtkConfiguration >> configureOSX: anApplication [

	self ensureAppearance: self macAppearanceName. 
	self installTheme: self macThemeName.
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self macStyle
]

{ #category : #configuring }
CrGtkConfiguration >> configureUnix: anApplication [

	self unixThemeName 
		ifNotNil: [ :aName | self installTheme: aName ].
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self unixStyle
]

{ #category : #configuring }
CrGtkConfiguration >> configureWindows: anApplication [

	self installTheme: self windowsThemeName.
	self addCSSProviderFromString: self commonStyle.
	self addCSSProviderFromString: self windowsStyle
]

{ #category : #configuring }
CrGtkConfiguration >> ensureAppearance: aName [

	MpSettings ensureAppearance: aName
]

{ #category : #accessing }
CrGtkConfiguration >> iconProvider [

	^ iconProvider ifNil: [ 
		iconProvider := CrIconProvider new
			addLocation: self iconsDir;
			addLocation: self themeIconsDir;
			yourself ] 
]

{ #category : #'accessing resources' }
CrGtkConfiguration >> iconsDir [

	^ self model paths iconsDir
]

{ #category : #accessing }
CrGtkConfiguration >> macAppearanceName [

	^ 'NSAppearanceNameAqua'
]

{ #category : #'accessing style' }
CrGtkConfiguration >> macStyle [

	^ '
.cronoText { font: 12pt "Monaco" }
'
]

{ #category : #accessing }
CrGtkConfiguration >> macThemeName [
		
	^ 'Mojave-light'
]

{ #category : #accessing }
CrGtkConfiguration >> model [

	^ CrModelApplication current
]

{ #category : #'accessing resources' }
CrGtkConfiguration >> resourcesDir [

	^ self model paths resourcesDir
]

{ #category : #'accessing resources' }
CrGtkConfiguration >> themeIconsDir [

	^ self iconsDir / 'light'
]

{ #category : #'accessing style' }
CrGtkConfiguration >> unixStyle [

	^ '
.cronoText { font: 11pt "Monospace Regular" }
'
]

{ #category : #accessing }
CrGtkConfiguration >> unixThemeName [

	^ 'Adwaita'
]

{ #category : #'accessing style' }
CrGtkConfiguration >> windowsStyle [

	^ '
.cronoText { font: 10pt "Microsoft Sans Serif" }
'
]

{ #category : #accessing }
CrGtkConfiguration >> windowsThemeName [

	^ 'Windows-10-master'
]
