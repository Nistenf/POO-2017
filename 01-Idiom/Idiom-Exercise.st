!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'a 4/20/2017 20:53:41'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |	
	
	customerBook := CustomerBook  new.	
	self testearSi: [customerBook addCustomerNamed: 'John Lennon'.] tardaMenosMilisegundosQue: 50.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'a 4/20/2017 20:55:01'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.	

	self testearSi: [ customerBook removeCustomerNamed: paulMcCartney. ] tardaMenosMilisegundosQue: 100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'AI 4/24/2017 23:44:52'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self testearQue: [customerBook addCustomerNamed: ''.] arrojaExcepcionDeTipo: Error yCumplePostcondiciones: [ :anError | customerBook isEmpty & anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.]! !

!IdiomTest methodsFor: 'testing' stamp: 'AI 4/24/2017 23:44:28'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self testearQue: [ customerBook removeCustomerNamed: 'Paul McCartney'. ] arrojaExcepcionDeTipo: NotFound yCumplePostcondiciones: [ :anError | customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: johnLennon].! !

!IdiomTest methodsFor: 'testing' stamp: 'AI 4/24/2017 23:14:29'!
testearQue: colaborationToTest arrojaExcepcionDeTipo: tipoExcepcion yCumplePostcondiciones: postcondicionesBlock
	[ colaborationToTest value.
	self fail ]
		on: tipoExcepcion
		do: [ :anError | 
			self assert: (postcondicionesBlock value: anError).]! !

!IdiomTest methodsFor: 'testing' stamp: 'a 4/20/2017 20:51:16'!
testearSi: aBlock tardaMenosMilisegundosQue: unaCantidadDeMilisegundos
	
	| millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < unaCantidadDeMilisegundos
	! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
