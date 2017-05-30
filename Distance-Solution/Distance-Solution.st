!classDefinition: #DistanciaTests category: #'Distance-Solution'!
TestCase subclass: #DistanciaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

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

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:27:17'!
test18OneMeterIsSmallerThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self assert: unMetro < dosMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:30:15'!
test19TwoMetersArentSmallerThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self deny: dosMetros < unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:30:57'!
test20TwoMetersAreGreaterThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self assert: dosMetros > unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:31:33'!
test21OneMeterIsntGreaterThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self deny: unMetro > dosMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:34:29'!
test22TwoMetersAreGreaterOrEqualThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self assert: dosMetros >= unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:35:23'!
test23OneMeteriIsntGreaterOrEqualThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self deny: unMetro >= dosMetros.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:36:53'!
test24OneMeteriIsSmallerOrEqualThanOneMeter
	| unMetro |
	
	unMetro := Distancia withMeters: 1.
	
	self assert: unMetro <= unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:37:40'!
test25TwoMeterArentSmallerOrEqualThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Distancia withMeters: 1.
	dosMetros := Distancia withMeters: 2.
	
	self deny: dosMetros <= unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:40:06'!
test26OneHundredCentimetersEqualOneMeter
	| unMetro cienCentimetros |
	
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].	
	unMetro := Distancia withMeters: 1.
	cienCentimetros := Distancia withUnit: 'centimeters' andValue: 100.
	
	self assert: cienCentimetros = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:40:12'!
test27NinetyNineCentimetersDoNotEqualOneMeter
	| unMetro noventaYNueveCentimetros |
	
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].	
	unMetro := Distancia withMeters: 1.
	noventaYNueveCentimetros := Distancia withUnit: 'centimeters' andValue: 99.
	
	self deny: noventaYNueveCentimetros = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:40:24'!
test28AThousandMilimetersEqualOneMeter
	| unMetro milMilimetros |
	
	Distancia addUnit: 'milimeters' withConversionRuleToMeters: [:aValue | aValue / 1000].	
	unMetro := Distancia withMeters: 1.
	milMilimetros := Distancia withUnit: 'milimeters' andValue: 1000.
	
	self assert: milMilimetros = unMetro.! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:05:56'!
test29CanAddNewUnit
	self shouldnt: [	
	Distancia addUnit: 'lightyear' withConversionRuleToMeters: [ :aValue | aValue * 9460730472580800 ] ]
	raise: Error - MessageNotUnderstood .! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:36:30'!
test30CannotCreateDistanceWithNonExistingUnit
	self should: [ Distancia withUnit: 'unidadNoExistente' andValue: 1  ]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError | self assert: anError messageText equals: Distancia undefinedUnitError ].! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 19:10:31'!
test31CanCreateDistanceIntervalWithoutDefinedStep
	| anInterval unMetro dosMetros tresMetros |

	unMetro := Distancia withUnit: 'meters' andValue: 1.
	dosMetros := Distancia withUnit: 'meters' andValue: 2.
	tresMetros := Distancia withUnit: 'meters' andValue: 3.
	anInterval := unMetro to: tresMetros.
	self assert: anInterval = (OrderedCollection newFrom: {unMetro. dosMetros. tresMetros }).
! !

!DistanciaTests methodsFor: 'tests' stamp: 'a 5/30/2017 19:14:12'!
test32CanCreateDistanceIntervalWithStep
	| anInterval unMetro dosMetros tresMetros cincuentaCentimetros |
	
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].
	unMetro := Distancia withUnit: 'meters' andValue: 1.
	dosMetros := Distancia withUnit: 'meters' andValue: 2.
	tresMetros := Distancia withUnit: 'meters' andValue: 3.
	cincuentaCentimetros  := Distancia withUnit: 'centimeters' andValue: 50.
	anInterval := unMetro to: tresMetros by: cincuentaCentimetros.
	self assert: anInterval = (OrderedCollection newFrom:
		{unMetro. unMetro + cincuentaCentimetros. dosMetros.  dosMetros  + cincuentaCentimetros. tresMetros }).
! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:17:58'!
minusOneMeter
	^ Distancia withUnit: 'meters' andValue: -1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:19:22'!
oneCentimeter
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Distancia withUnit: 'centimeters' andValue: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:36'!
oneHundredCentimeters
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Distancia withUnit: 'centimeters' andValue: 100.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:12'!
oneMeter
	^ Distancia withUnit: 'meters' andValue: 1.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:47'!
twoHundredCentimeters
	Distancia addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Distancia withUnit: 'centimeters' andValue: 200.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:21:00'!
twoMeters
	^ Distancia withUnit: 'meters' andValue: 2.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:21:17'!
zeroMeters
	^ Distancia withUnit: 'meters' andValue: 0.! !


!classDefinition: #Distancia category: #'Distance-Solution'!
Object subclass: #Distancia
	instanceVariableNames: 'meters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distancia methodsFor: 'initialization' stamp: 'a 5/23/2017 21:09:13'!
initilizeWithMeters: aNumber
	aNumber < 0 ifTrue: [ self error: self class negativeDistanceError ]
					ifFalse: [ meters := aNumber ].! !


!Distancia methodsFor: 'comparing' stamp: 'a 5/30/2017 17:30:00'!
< aDistancia 
	^ meters < aDistancia meters.! !

!Distancia methodsFor: 'comparing' stamp: 'a 5/30/2017 17:38:23'!
<= aDistancia 
	^ self = aDistancia or: [ self < aDistancia ].! !

!Distancia methodsFor: 'comparing' stamp: 'a 5/23/2017 19:54:53'!
= anObject
	^ meters = anObject meters.! !

!Distancia methodsFor: 'comparing' stamp: 'a 5/30/2017 17:31:56'!
> aDistancia 
	^ meters > aDistancia meters.! !

!Distancia methodsFor: 'comparing' stamp: 'a 5/30/2017 17:38:48'!
>= aDistancia 
	^ self = aDistancia or: [self > aDistancia].! !


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

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 18:59:15'!
to: aDistancia 
	| interval collection |
	
	collection := OrderedCollection new.
	interval := Interval from: meters to: aDistancia meters.
	interval do: [ :aValue | collection add: (self class withUnit: 'meters' andValue: aValue)].
	^ collection.! !

!Distancia methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:15:26'!
to: aDistancia by: aStep 
	| interval collection |
	
	collection := OrderedCollection new.
	interval := Interval from: meters to: aDistancia meters by: aStep meters.
	interval do: [ :aValue | collection add: (self class withUnit: 'meters' andValue: aValue)].
	^ collection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Distance-Solution'!
Distancia class
	instanceVariableNames: 'conversionRules'!

!Distancia class methodsFor: 'errors' stamp: 'a 5/23/2017 21:10:25'!
canOnlySumDistancesError
	^ 'A una distancia solo se le pueden sumar distancias'.! !

!Distancia class methodsFor: 'errors' stamp: 'a 5/23/2017 21:08:49'!
negativeDistanceError
	^ 'No puede existir una distancia negativa'.! !

!Distancia class methodsFor: 'errors' stamp: 'a 5/30/2017 18:36:18'!
undefinedUnitError
	^ 'No se puede crear una distancia con una unidad no agregada al sistema.'.! !


!Distancia class methodsFor: 'instance creation' stamp: 'a 5/23/2017 19:48:38'!
withMeters: aNumber
	^self new initilizeWithMeters: aNumber. ! !

!Distancia class methodsFor: 'instance creation' stamp: 'a 5/30/2017 18:35:34'!
withUnit: aUnit andValue: aValue
	| conversionRule | 
	conversionRule := conversionRules at: aUnit ifAbsent: [ self error: self undefinedUnitError ]. 
	^self withMeters: (conversionRule value: aValue).! !


!Distancia class methodsFor: 'unit management' stamp: 'a 5/30/2017 18:18:05'!
addUnit: aUnitName withConversionRuleToMeters: aConversionRule 
	self initializeRulesIfNecessary.
	conversionRules at: aUnitName put: aConversionRule.! !


!Distancia class methodsFor: 'class initialization' stamp: 'a 5/30/2017 18:47:54'!
initializeRulesIfNecessary
	"Por cuestiones implementativas tenemos que comparar con nil para saber si la variable ya ha sido inicializada"
	conversionRules ifNil: [ conversionRules := Dictionary new. Distancia addUnit: 'meters' withConversionRuleToMeters: [ :aValue | aValue ] ].! !
