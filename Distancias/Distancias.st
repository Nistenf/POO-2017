!classDefinition: #DistanciaTests category: #Distancias!
TestCase subclass: #DistanciaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancias'!

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 19:52:08'!
test01aMeterIsEqualToAnotherMeter

	| aUnMetro anotherUnMetro |
	aUnMetro := Distancia withMeters: 1.
	anotherUnMetro := Distancia withMeters: 1.
	
	self assert: aUnMetro = anotherUnMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 19:53:20'!
test02oneMeterIsNotEqualToTwoMeters
	| oneMeter twoMeters |
	oneMeter := Distancia withMeters: 1.
	twoMeters := Distancia withMeters: 2.
	
	self deny: oneMeter = twoMeters.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:08:13'!
test03DistancesCannotBeInitializedWithNegativeMeters
	| aDistance |
	
	self
	should: [ aDistance := Distancia withMeters: -1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: Distancia negativeDistanceError ].! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:12:15'!
test04OneMeterPlusOneMeterEqualsTwoMeters
	| aUnMetro anotherUnMetro dosMetros |
	
	aUnMetro := Distancia withMeters: 1.
	anotherUnMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self assert: (aUnMetro + anotherUnMetro) = dosMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:14:53'!
test05OneMeterPlusThreeMetersDoesNotEqualsTwoMeters
	| unMetro dosMetros tresMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	tresMetros := Distancia withMeters: 3.
	
	self deny: (unMetro + tresMetros) = dosMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:17:07'!
test06OneMetersTimesFourEqualsFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Distancia withMeters: 1.
	cuatroMetros := Distancia withMeters: 4.
	
	self assert: (unMetro * 4) = cuatroMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:18:25'!
test07OneMetersTimesThreeDoesNotEqualFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Distancia withMeters: 1.
	cuatroMetros := Distancia withMeters: 4.
	
	self deny: (unMetro * 3) = cuatroMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:20:28'!
test08FourTimesOneMeterEqualsFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Distancia withMeters: 1.
	cuatroMetros := Distancia withMeters: 4.
	
	self assert: (4 * unMetro) = cuatroMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:35:47'!
test09ThreeTimesOneMeterDoesNotEqualFourMeters
	"Este test se hizo haciendo testing, no tdd, ya que para el test anterior la solucion mas simple era ganeral"
	| unMetro cuatroMetros |
	
	unMetro := Distancia withMeters: 1.
	cuatroMetros := Distancia withMeters: 4.
	
	self deny: (3 * unMetro) = cuatroMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:37:04'!
test10ThreeMetersDividedByThreeEqualsOneMeter
	| unMetro tresMetros |
	
	unMetro := Distancia withMeters: 1.
	tresMetros := Distancia withMeters: 3.
	
	self assert: (tresMetros / 3) = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:39:40'!
test11EigthMetersDividedByTwoDoesNotEqualOneMeter
	| unMetro ochoMetros |
	
	unMetro := Distancia withMeters: 1.
	ochoMetros := Distancia withMeters: 8.
	
	self deny: (ochoMetros / 2) = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:42:24'!
test12CannotDivideANumberByADistance
	| unMetro |
	
	unMetro := Distancia withMeters: 1.
	
	self 
		should: [ 4 / unMetro ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: 'No se puede dividir por una distancia']! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:10:36'!
test13CannotAddANonDistanceToADistance
	| unMetro |
	
	unMetro := Distancia withMeters: 1.
	
	self 
		should: [ unMetro + 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: Distancia canOnlySumDistancesError ]! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:12:02'!
test14CannotAddADistanceToANonDistance
	| unMetro |
	
	unMetro := Distancia withMeters: 1.
	
	self 
		should: [ 2 + unMetro ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: Distancia canOnlySumDistancesError ]! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:02:36'!
test15TwoMetersMinusOneMeterEqualsOneMeter
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self assert: (dosMetros - unMetro) = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:02:29'!
test16ThreeMetersMinusOneMeterDoesNotEqualOneMeter
	| unMetro tresMetros |
	
	unMetro := Distancia withMeters: 1.
	tresMetros := Distancia withMeters: 3.
	
	self deny: (tresMetros - unMetro) = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:12:43'!
test17CannotSubstractaFromADistanceAGreaterDistance
	"este test se hizo via testing"
	| unMetro tresMetros |
	
	unMetro := Distancia withMeters: 1.
	tresMetros := Distancia withMeters: 3.
	
	self
	should: [ unMetro - tresMetros ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | self assert: anError messageText equals: Distancia negativeDistanceError ].! !


!classDefinition: #Distancia category: #Distancias!
Object subclass: #Distancia
	instanceVariableNames: 'meters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distancias'!

!Distancia methodsFor: 'initialization' stamp: 'a 5/23/2017 21:09:13'!
initilizeWithMeters: aNumber
	aNumber < 0 ifTrue: [ self error: self class negativeDistanceError ]
					ifFalse: [ meters := aNumber ].! !


!Distancia methodsFor: 'comparing' stamp: 'a 5/23/2017 19:54:53'!
= anObject
	^ meters = anObject meters.! !


!Distancia methodsFor: 'accessing' stamp: 'a 5/23/2017 19:55:17'!
meters
	^ meters.! !


!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:18:48'!
* aNumber
	^ self class withMeters: meters * aNumber.! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 21:10:57'!
+ anObject
	self class = anObject class ifTrue: [^ self class withMeters: meters + anObject meters ].
	^ self error: self class canOnlySumDistancesError .! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 21:02:59'!
- aDistancia 
	^ self class withMeters: meters - aDistancia meters.! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:39:58'!
/ aNumber 
	^ self class withMeters: meters / aNumber.! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:56:23'!
adaptToInteger: anInteger andSend: aSymbol 
	aSymbol = #* ifTrue: [
		^ self * anInteger ].
	aSymbol = #/ ifTrue: [ self error: 'No se puede dividir por una distancia' ].
	aSymbol = #+ ifTrue: [ self error: 'A una distancia solo se le pueden sumar distancias' ].! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:31:04'!
adaptToNumber: aNumber andSend: aSymbol 
	self shouldBeImplemented! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:44:16'!
isZero
	^ false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #Distancias!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'errors' stamp: 'a 5/23/2017 21:10:25'!
canOnlySumDistancesError
	^ 'A una distancia solo se le pueden sumar distancias'.! !

!Distancia class methodsFor: 'errors' stamp: 'a 5/23/2017 21:08:49'!
negativeDistanceError
	^ 'No puede existir una distancia negativa'.! !


!Distancia class methodsFor: 'initialization' stamp: 'a 5/23/2017 19:48:38'!
withMeters: aNumber
	^self new initilizeWithMeters: aNumber. ! !
