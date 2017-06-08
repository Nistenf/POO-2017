!classDefinition: #MeasureInterval category: #'Measure-Solution'!
Interval subclass: #MeasureInterval
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'errors' stamp: 'a 6/8/2017 16:59:19'!
errorDifferentUnitTypes
	^ 'No se pueden crear intervalos entre unidades de distintos tipos'! !


!MeasureInterval class methodsFor: 'instance creation' stamp: 'a 6/6/2017 21:13:14'!
from: startMeasure to: endMeasure
	"De manera arbitraria hemos decidido que el step por default sea 1 en la unidad del inicio del intervalo"
	^ self from: startMeasure to: endMeasure by: (Measure withUnit: startMeasure unit andValue: 1).  ! !

!MeasureInterval class methodsFor: 'instance creation' stamp: 'a 6/8/2017 17:06:39'!
from: startMeasure to: endMeasure by: stepMeasure
	| count end |
	
	(startMeasure unit type = endMeasure unit type and: [ endMeasure unit type = stepMeasure unit type ]) ifFalse: [ self error: self errorDifferentUnitTypes ] .
	count _ endMeasure - startMeasure / stepMeasure + 1.
	(count closeTo: count rounded)
		ifTrue: [
			count _ count rounded.
			end _ endMeasure ]
		ifFalse: [
			count _ count truncated.
			end _ count-1 * stepMeasure + startMeasure ].
	^self from: startMeasure to: end count: count! !


!classDefinition: #MeasureTests category: #'Measure-Solution'!
TestCase subclass: #MeasureTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 19:52:08'!
test01aMeterIsEqualToAnotherMeter

	| aUnMetro anotherUnMetro |
	aUnMetro := Measure withMeters: 1.
	anotherUnMetro := Measure withMeters: 1.
	
	self assert: aUnMetro = anotherUnMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 19:53:20'!
test02oneMeterIsNotEqualToTwoMeters
	| oneMeter twoMeters |
	oneMeter := Measure withMeters: 1.
	twoMeters := Measure withMeters: 2.
	
	self deny: oneMeter = twoMeters.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/1/2017 19:58:35'!
test03MeasuresCanBeInitializedWithNegativeMeters
	| aMeasure |
	
	self
	shouldnt: [ aMeasure := Measure withMeters: -1 ] raise: Error. ! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:12:15'!
test04OneMeterPlusOneMeterEqualsTwoMeters
	| aUnMetro anotherUnMetro dosMetros |
	
	aUnMetro := Measure withMeters: 1.
	anotherUnMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self assert: (aUnMetro + anotherUnMetro) = dosMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:14:53'!
test05OneMeterPlusThreeMetersDoesNotEqualsTwoMeters
	| unMetro dosMetros tresMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	tresMetros := Measure withMeters: 3.
	
	self deny: (unMetro + tresMetros) = dosMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:17:07'!
test06OneMetersTimesFourEqualsFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Measure withMeters: 1.
	cuatroMetros := Measure withMeters: 4.
	
	self assert: (unMetro * 4) = cuatroMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:18:25'!
test07OneMetersTimesThreeDoesNotEqualFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Measure withMeters: 1.
	cuatroMetros := Measure withMeters: 4.
	
	self deny: (unMetro * 3) = cuatroMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:20:28'!
test08FourTimesOneMeterEqualsFourMeters
	| unMetro cuatroMetros |
	
	unMetro := Measure withMeters: 1.
	cuatroMetros := Measure withMeters: 4.
	
	self assert: (4 * unMetro) = cuatroMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:35:47'!
test09ThreeTimesOneMeterDoesNotEqualFourMeters
	"Este test se hizo haciendo testing, no tdd, ya que para el test anterior la solucion mas simple era ganeral"
	| unMetro cuatroMetros |
	
	unMetro := Measure withMeters: 1.
	cuatroMetros := Measure withMeters: 4.
	
	self deny: (3 * unMetro) = cuatroMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:37:04'!
test10ThreeMetersDividedByThreeEqualsOneMeter
	| unMetro tresMetros |
	
	unMetro := Measure withMeters: 1.
	tresMetros := Measure withMeters: 3.
	
	self assert: (tresMetros / 3) = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:39:40'!
test11EigthMetersDividedByTwoDoesNotEqualOneMeter
	| unMetro ochoMetros |
	
	unMetro := Measure withMeters: 1.
	ochoMetros := Measure withMeters: 8.
	
	self deny: (ochoMetros / 2) = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 20:42:24'!
test12CannotDivideANumberByAMeasure
	| unMetro |
	
	unMetro := Measure withMeters: 1.
	
	self 
		should: [ 4 / unMetro ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: 'No se puede dividir por una measure']! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:10:36'!
test13CannotAddANonMeasureToAMeasure
	| unMetro |
	
	unMetro := Measure withMeters: 1.
	
	self 
		should: [ unMetro + 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: Measure canOnlySumMeasuresError ]! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:12:02'!
test14CannotAddAMeasureToANonMeasure
	| unMetro |
	
	unMetro := Measure withMeters: 1.
	
	self 
		should: [ 2 + unMetro ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText equals: Measure canOnlySumMeasuresError ]! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:02:36'!
test15TwoMetersMinusOneMeterEqualsOneMeter
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self assert: (dosMetros - unMetro) = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/23/2017 21:02:29'!
test16ThreeMetersMinusOneMeterDoesNotEqualOneMeter
	| unMetro tresMetros |
	
	unMetro := Measure withMeters: 1.
	tresMetros := Measure withMeters: 3.
	
	self deny: (tresMetros - unMetro) = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/1/2017 20:02:26'!
test17CanSubstractFromAMeasureAGreaterMeasure
	"este test se hizo via testing"
	| unMetro tresMetros |
	
	unMetro := Measure withMeters: 1.
	tresMetros := Measure withMeters: 3.
	
	self shouldnt: [unMetro - tresMetros ] raise: Error.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:27:17'!
test18OneMeterIsSmallerThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self assert: unMetro < dosMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:30:15'!
test19TwoMetersArentSmallerThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self deny: dosMetros < unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:30:57'!
test20TwoMetersAreGreaterThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self assert: dosMetros > unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:31:33'!
test21OneMeterIsntGreaterThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self deny: unMetro > dosMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:34:29'!
test22TwoMetersAreGreaterOrEqualThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self assert: dosMetros >= unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:35:23'!
test23OneMeteriIsntGreaterOrEqualThanTwoMeters
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self deny: unMetro >= dosMetros.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:36:53'!
test24OneMeteriIsSmallerOrEqualThanOneMeter
	| unMetro |
	
	unMetro := Measure withMeters: 1.
	
	self assert: unMetro <= unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 17:37:40'!
test25TwoMeterArentSmallerOrEqualThanOneMeter
	| unMetro dosMetros |
	
	unMetro := Measure withMeters: 1.
	dosMetros := Measure withMeters: 2.
	
	self deny: dosMetros <= unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/6/2017 20:31:00'!
test26OneHundredCentimetersEqualOneMeter
	| unMetro cienCentimetros |
	
	unMetro := Measure withMeters: 1.
	cienCentimetros := Measure withUnit: centimetro andValue: 100.
	
	self assert: cienCentimetros = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/6/2017 20:49:57'!
test27NinetyNineCentimetersDoNotEqualOneMeter
	| unMetro noventaYNueveCentimetros |
	
	unMetro := Measure withMeters: 1.
	noventaYNueveCentimetros := Measure withUnit: centimetro andValue: 99.
	
	self deny: noventaYNueveCentimetros = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/6/2017 20:50:10'!
test28AThousandMilimetersEqualOneMeter
	| unMetro milMilimetros |
	
	unMetro := Measure withMeters: 1.
	milMilimetros := Measure withUnit: milimetro andValue: 1000.
	
	self assert: milMilimetros = unMetro.! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/8/2017 17:53:19'!
test29CanAddNewUnit
	self shouldnt: [	
	SimpleUnit createWithName: 'lightyear' andType: 'distancia' andConversionRuleToReferenceUnit: [ :aValue | aValue * 9460730472580800 ] andConversionRuleFromReferenceUnit:  [:aValue | aValue / 9460730472580800 ] ]
	raise: Error - MessageNotUnderstood .! !

!MeasureTests methodsFor: 'tests' stamp: 'a 5/30/2017 18:36:30'!
test30CannotCreateMeasureWithNonExistingUnit
	self should: [ Measure withUnit: 'unidadNoExistente' andValue: 1  ]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError | self assert: anError messageText equals: Measure undefinedUnitError ].! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/6/2017 20:51:15'!
test31CanCreateMeasureIntervalWithoutDefinedStep
	| anInterval unMetro dosMetros tresMetros |

	unMetro := Measure withUnit: metro andValue: 1.
	dosMetros := Measure withUnit: metro andValue: 2.
	tresMetros := Measure withUnit: metro andValue: 3.
	anInterval := unMetro to: tresMetros.
	self assert: anInterval = (OrderedCollection newFrom: {unMetro. dosMetros. tresMetros }).
! !

!MeasureTests methodsFor: 'tests' stamp: 'a 6/6/2017 20:51:37'!
test32CanCreateMeasureIntervalWithStep
	| anInterval unMetro dosMetros tresMetros cincuentaCentimetros |
	
	unMetro := Measure withUnit: metro andValue: 1.
	dosMetros := Measure withUnit: metro andValue: 2.
	tresMetros := Measure withUnit: metro andValue: 3.
	cincuentaCentimetros  := Measure withUnit: centimetro andValue: 50.
	anInterval := unMetro to: tresMetros by: cincuentaCentimetros.
	self assert: anInterval = (OrderedCollection newFrom:
		{unMetro. unMetro + cincuentaCentimetros. dosMetros.  dosMetros  + cincuentaCentimetros. tresMetros }).
! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'initialization' stamp: 'a 6/6/2017 19:37:40'!
initializeWithUnit: aUnit andValue: aValue
	unit := aUnit.
	amount := aValue.! !


!Measure methodsFor: 'comparing' stamp: 'a 6/1/2017 20:24:03'!
< aMeasure 
	^ amount < aMeasure amount.! !

!Measure methodsFor: 'comparing' stamp: 'a 5/30/2017 17:38:23'!
<= aMeasure 
	^ self = aMeasure or: [ self < aMeasure ].! !

!Measure methodsFor: 'comparing' stamp: 'a 6/6/2017 20:33:20'!
= anObject
	^ self amountInReferenceUnit = anObject amountInReferenceUnit.! !

!Measure methodsFor: 'comparing' stamp: 'a 6/1/2017 20:24:12'!
> aMeasure 
	^ amount > aMeasure amount.! !

!Measure methodsFor: 'comparing' stamp: 'a 5/30/2017 17:38:48'!
>= aMeasure 
	^ self = aMeasure or: [self > aMeasure].! !


!Measure methodsFor: 'accessing' stamp: 'a 6/1/2017 20:22:40'!
amount
	^ amount.! !

!Measure methodsFor: 'accessing' stamp: 'a 6/6/2017 20:34:20'!
amountInReferenceUnit
	^ unit convertToReferenceUnit: amount.! !

!Measure methodsFor: 'accessing' stamp: 'a 6/1/2017 20:25:46'!
unit
	^ unit.! !


!Measure methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:56:23'!
adaptToInteger: anInteger andSend: aSymbol 
	aSymbol = #* ifTrue: [
		^ self * anInteger ].
	aSymbol = #/ ifTrue: [ self error: 'No se puede dividir por una measure' ].
	aSymbol = #+ ifTrue: [ self error: 'A una measure solo se le pueden sumar measures' ].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:31:04'!
adaptToNumber: aNumber andSend: aSymbol 
	self shouldBeImplemented! !

!Measure methodsFor: 'as yet unclassified' stamp: 'a 6/8/2017 18:51:34'!
asString
	^ amount asString, ' ', unit asString.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'a 5/23/2017 20:44:16'!
isZero
	^ false.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'a 6/6/2017 21:03:00'!
to: aMeasure 
	^ MeasureInterval from: self to: aMeasure.

! !

!Measure methodsFor: 'as yet unclassified' stamp: 'a 6/6/2017 20:52:09'!
to: aMeasure by: aStep 
	| interval collection |
	
	collection := OrderedCollection new.
	interval := Interval from: amount to: aMeasure amount by: aStep amount.
	interval do: [ :aValue | collection add: (self class withUnit: metro andValue: aValue)].
	^ collection.! !


!Measure methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:16:43'!
* anObject
	
	self doWIthOperator: anObject 
	ifNumber: [ ^ Measure withUnit: unit  andValue: amount * anObject ]
	ifMeasure: [ ^ Measure withUnit: unit * anObject unit andValue: amount * anObject amount]
	ifUnit: [ anObject class = Unit ifTrue:[	^ self * Measure withUnit: anObject andValue: 1 ]]
	otherwiseRaise: self class errorInvalidProduct.! !

!Measure methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:10:20'!
+ anObject
	self class = anObject class ifTrue: [^ self class withUnit: self unit andValue: (self unit convertFromReferenceUnit: self amountInReferenceUnit + anObject  amountInReferenceUnit )].
	^ self error: self class canOnlySumMeasuresError .! !

!Measure methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:10:56'!
- anObject
	self class = anObject class ifTrue: [^ self class withUnit: self unit andValue: (self unit convertFromReferenceUnit: self amountInReferenceUnit - anObject  amountInReferenceUnit )].
	^ self error: self class canOnlySubstractMeasuresError.! !

!Measure methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:15:34'!
/ anObject

	self doWIthOperator: anObject
	ifNumber: [ ^ Measure withUnit: unit  andValue: amount / anObject ]
	ifMeasure: [^ Measure withUnit: unit / anObject unit andValue: amount / anObject amount]
	ifUnit: [ anObject class = Unit ifTrue: [^ self / Measure withUnit: anObject andValue: 1 ] ] 
	otherwiseRaise: self class errorInvalidDivision.! !

!Measure methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:13:50'!
doWIthOperator: anOperator ifNumber: numberBlock ifMeasure: measureBlock ifUnit: unitBlock otherwiseRaise: aString	
	
	Measure = anOperator class ifTrue: measureBlock.
	Unit = anOperator class ifTrue: unitBlock.
	anOperator isNumber ifTrue: numberBlock.
	^self error: aString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: 'conversionRules unit'!

!Measure class methodsFor: 'errors' stamp: 'a 6/8/2017 17:11:09'!
canOnlySubstractMeasuresError
	^ 'A una measure solo se le pueden restar measures'.! !

!Measure class methodsFor: 'errors' stamp: 'a 5/23/2017 21:10:25'!
canOnlySumMeasuresError
	^ 'A una measure solo se le pueden sumar measures'.! !

!Measure class methodsFor: 'errors' stamp: 'a 6/8/2017 17:34:38'!
errorInvalidDivision
	^ 'Una Measure solo se puede dividir por otra Measure, una Unit o un numero'! !

!Measure class methodsFor: 'errors' stamp: 'a 6/8/2017 17:40:09'!
errorInvalidProduct
	^ 'Una Measure solo se puede multiplicar por otra Measure, una Unit o un numero'! !

!Measure class methodsFor: 'errors' stamp: 'a 6/6/2017 20:27:08'!
errorTypeAlreadyHasAReferenceUnit
	^ 'Ya existe una unidad de referencia para el tipo. Crea la nueva en funcion de esta'.! !

!Measure class methodsFor: 'errors' stamp: 'a 5/23/2017 21:08:49'!
negativeMeasureError
	^ 'No puede existir una measure negativa'.! !

!Measure class methodsFor: 'errors' stamp: 'a 5/30/2017 18:36:18'!
undefinedUnitError
	^ 'No se puede crear una measure con una unidad no agregada al sistema.'.! !


!Measure class methodsFor: 'instance creation' stamp: 'a 6/6/2017 20:48:41'!
withMeters: aNumber
	^self withUnit: metro andValue: aNumber. ! !

!Measure class methodsFor: 'instance creation' stamp: 'a 6/6/2017 19:40:18'!
withUnit: aUnit andValue: aValue
	aUnit class = Unit ifFalse: [ self error: self undefinedUnitError ].
	^self new initializeWithUnit: aUnit andValue: aValue.! !



!Measure class methodsFor: 'class initialization' stamp: 'a 5/30/2017 18:47:54'!
initializeRulesIfNecessary
	"Por cuestiones implementativas tenemos que comparar con nil para saber si la variable ya ha sido inicializada"
	conversionRules ifNil: [ conversionRules := Dictionary new. Measure addUnit: 'meters' withConversionRuleToMeters: [ :aValue | aValue ] ].! !


!Measure class methodsFor: 'as yet unclassified' stamp: 'a 6/6/2017 21:30:07'!
TODO
	^ 'aritmetica de unidades, incluyendo subclasificar Unit. ver como carajo sumar unidades de distinto tipo. corregir la suma y demas operaciones. chequeos de unidades. tests.'! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:17:58'!
minusOneMeter
	^ Measure withUnit: 'meters' andValue: -1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:19:22'!
oneCentimeter
	Measure addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Measure withUnit: 'centimeters' andValue: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:36'!
oneHundredCentimeters
	Measure addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Measure withUnit: 'centimeters' andValue: 100.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:12'!
oneMeter
	^ Measure withUnit: 'meters' andValue: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:20:47'!
twoHundredCentimeters
	Measure addUnit: 'centimeters' withConversionRuleToMeters: [:aValue | aValue / 100].  
	^ Measure withUnit: 'centimeters' andValue: 200.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:21:00'!
twoMeters
	^ Measure withUnit: 'meters' andValue: 2.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'a 5/30/2017 19:21:17'!
zeroMeters
	^ Measure withUnit: 'meters' andValue: 0.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:59:06'!
* anObject
	self subclassResponsibility 
! !

!Unit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:58:36'!
+ anObject
	self subclassResponsibility 
! !

!Unit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:59:04'!
- anObject
	self subclassResponsibility 
! !

!Unit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 17:59:07'!
/ anObject
	self subclassResponsibility 
! !

!Unit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:17:01'!
doWIthOperator: anOperator ifNumber: numberBlock ifMeasure: measureBlock ifUnit: unitBlock otherwiseRaise: aString	
	
	Measure = anOperator class ifTrue: measureBlock.
	Unit = anOperator class ifTrue: unitBlock.
	anOperator isNumber ifTrue: numberBlock.
	^self error: aString.! !


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
Unit subclass: #CompoundUnit
	instanceVariableNames: 'denominator numerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:53:57'!
* anObject
	self doWIthOperator: anObject
	ifNumber: [ ^Measure withUnit: self andValue: anObject ]
	ifMeasure: [ ^Measure withUnit: anObject unit * self andValue: anObject amount]
	ifUnit: [ ^anObject multiplyByCompoundUnit: self ]
	otherwiseRaise: self class errorInvalidOperators.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:59:39'!
+ anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self asString, ' + ', anObject asString ]
	ifMeasure: [ ^ self asString, ' + ', anObject asString ]
	ifUnit: [ ^ self asString, ' + ', anObject asString ]
	otherwiseRaise: self class errorInvalidOperators.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:59:51'!
- anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self asString, ' - ', anObject asString ]
	ifMeasure: [ ^ self asString, ' - ', anObject asString ]
	ifUnit: [ ^ self asString, ' - ', anObject asString ]
	otherwiseRaise: self class errorInvalidOperators.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:57:09'!
/ anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self * (1 / anObject) ]
	ifMeasure: [ ^ self * (1 / anObject)]
	ifUnit: [ ^anObject divideCompoundUnit: self ]
	otherwiseRaise: self class errorInvalidOperators.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:58:12'!
divideCompoundUnit: aCompoundUnit
	CompoundUnit  createWithNumerator: ( denominator addAll: aCompoundUnit numerator ) andDenominator: (numerator addAll: aCompoundUnit denominator ).! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:49:01'!
divideSimpleUnit: aSimpleUnit
	CompoundUnit  createWithNumerator: ( denominator add: aSimpleUnit ) andDenominator: numerator.! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:54:58'!
multiplyByCompoundUnit: aCompoundUnit
	CompoundUnit  createWithNumerator: (numerator addAll: aCompoundUnit numerator ) andDenominator: (denominator addAll: aCompoundUnit denominator ).! !

!CompoundUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:27:17'!
multiplyBySimpleUnit: aSimpleUnit
	CompoundUnit  createWithNumerator: (numerator add: aSimpleUnit ) andDenominator: denominator.! !


!CompoundUnit methodsFor: 'initialization' stamp: 'a 6/8/2017 18:32:46'!
initializeWithNumerator: numeratorCollection andDenominator: denominatorCollecion.
	numerator := numeratorCollection difference: denominatorCollecion .
	denominator := denominatorCollecion difference: numeratorCollection .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'instance creation' stamp: 'a 6/8/2017 18:29:46'!
createWithNumerator: numeratorCollection andDenominator: denominatorCollecion
	^ self new initializeWithNumerator: numeratorCollection andDenominator: denominatorCollecion.! !


!classDefinition: #SimpleUnit category: #'Measure-Solution'!
Unit subclass: #SimpleUnit
	instanceVariableNames: 'referenceUnit name conversionRuleToReferenceUnit conversionRuleFromReferenceUnit type'
	classVariableNames: 'SimpleUnitTypes'
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SimpleUnit methodsFor: 'initialization' stamp: 'a 6/6/2017 20:10:10'!
initializeWithName: aName andType: aTypeName.
	name := aName.
	type := aTypeName.
	conversionRuleToReferenceUnit := [:anAmount | anAmount ].
	conversionRuleFromReferenceUnit := [ :anAmount | anAmount ].! !

!SimpleUnit methodsFor: 'initialization' stamp: 'a 6/8/2017 17:56:42'!
initializeWithName: aName andType: aTypeName
	andConversionRuleToReferenceUnit: aConversionRuleToReferenceUnit andConversionRuleFromReferenceUnit: aConversionRuleFromReferenceUnit.
	
	
	name := aName.
	type := aTypeName.
	referenceUnit := SimpleUnitTypes at: type ifAbsent: [ self error: self class errorNoReferenceUnitForUnitType ].
	conversionRuleToReferenceUnit := aConversionRuleToReferenceUnit .
	conversionRuleFromReferenceUnit := aConversionRuleFromReferenceUnit .! !

!SimpleUnit methodsFor: 'initialization' stamp: 'a 6/8/2017 18:55:45'!
multiplyByCompoundUnit: aCompoundUnit
	CompoundUnit  createWithNumerator: ({self} addAll: aCompoundUnit numerator ) andDenominator: (aCompoundUnit denominator ).! !


!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:34:02'!
* anObject
	self doWIthOperator: anObject
	ifNumber: [ ^Measure withUnit: self andValue: anObject ]
	ifMeasure: [ ^Measure withUnit: anObject unit * self andValue: anObject amount]
	ifUnit: [ ^anObject multiplyBySimpleUnit: self ]
	otherwiseRaise: self class errorInvalidOperators.! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:52:21'!
+ anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self asString, ' + ', anObject asString ]
	ifMeasure: [ ^ self asString, ' + ', anObject asString ]
	ifUnit: [ ^ self asString, ' + ', anObject asString ]
	otherwiseRaise: self class errorInvalidOperators.! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:52:45'!
- anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self asString, ' - ', anObject asString ]
	ifMeasure: [ ^ self asString, ' - ', anObject asString ]
	ifUnit: [ ^ self asString, ' - ', anObject asString ]
	otherwiseRaise: self class errorInvalidOperators.! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:44:32'!
/ anObject
	self doWIthOperator: anObject
	ifNumber: [ ^ self * (1 / anObject) ]
	ifMeasure: [ ^ self * (1 / anObject) ]
	ifUnit: [ anObject divideSimpleUnit: self ]
	otherwiseRaise: self class errorInvalidOperators.! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:59:03'!
divideCompoundUnit: aCompoundUnit
	CompoundUnit  createWithNumerator: aCompoundUnit numerator andDenominator: ({self} addAll: aCompoundUnit denominator ).! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:46:24'!
divideSimpleUnit: aSimpleUnit
	CompoundUnit  createWithNumerator: { aSimpleUnit } andDenominator: {self}.! !

!SimpleUnit methodsFor: 'arithmetic' stamp: 'a 6/8/2017 18:25:32'!
multiplyBySimpleUnit: aSimpleUnit
	CompoundUnit  createWithNumerator: { self. aSimpleUnit.} andDenominator: {}.! !


!SimpleUnit methodsFor: 'accessing' stamp: 'a 6/8/2017 17:08:49'!
convertFromReferenceUnit: aValue 
	^ conversionRuleFromReferenceUnit value: aValue.! !

!SimpleUnit methodsFor: 'accessing' stamp: 'a 6/6/2017 20:35:16'!
convertToReferenceUnit: aValue 
	^ conversionRuleToReferenceUnit value: aValue.! !

!SimpleUnit methodsFor: 'accessing' stamp: 'a 6/1/2017 20:37:54'!
name
	^ name.! !

!SimpleUnit methodsFor: 'accessing' stamp: 'a 6/8/2017 16:57:47'!
type
	^ type.! !


!SimpleUnit methodsFor: 'as yet unclassified' stamp: 'a 6/8/2017 18:52:30'!
asString
	^ name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleUnit class' category: #'Measure-Solution'!
SimpleUnit class
	instanceVariableNames: ''!

!SimpleUnit class methodsFor: 'errors' stamp: 'a 6/8/2017 18:23:57'!
errorInvalidOperators
	^ 'Solo se puede operar entre numeros, Measures y Units'! !

!SimpleUnit class methodsFor: 'errors' stamp: 'a 6/6/2017 20:04:18'!
errorNoReferenceUnitForUnitType
	^ 'No existe una unidad de referencia para el tipo. Creala.'! !


!SimpleUnit class methodsFor: 'instance creation' stamp: 'a 6/8/2017 17:56:50'!
createWithName: aName andType: aTypeName
	| aUnit |
	aUnit := self new initializeWithName: aName andType: aTypeName.
	SimpleUnitTypes at: aTypeName ifPresent: [ :assoc | self error: self errorTypeAlreadyHasAReferenceUnit] ifAbsent: [ SimpleUnitTypes at: aTypeName put: aUnit ].
	Smalltalk at: aName asSymbol put: aUnit.
	^ aUnit.! !

!SimpleUnit class methodsFor: 'instance creation' stamp: 'a 6/6/2017 19:57:52'!
createWithName: aName andType: aTypeName 
andConversionRuleToReferenceUnit: aConversionRuleToReferenceUnit andConversionRuleFromReferenceUnit: aConversionRuleFromReferenceUnit

	| aUnit |
	aUnit := self new initializeWithName: aName andType: aTypeName
	andConversionRuleToReferenceUnit: aConversionRuleToReferenceUnit andConversionRuleFromReferenceUnit: aConversionRuleFromReferenceUnit.
	Smalltalk at: aName asSymbol put: aUnit.
	^ aUnit.! !


!SimpleUnit class methodsFor: 'class initialization' stamp: 'a 6/8/2017 17:56:54'!
initialize
	SimpleUnitTypes := Dictionary new.
	SimpleUnit createWithName: 'metro' andType: 'distancia'.
	SimpleUnit createWithName: 'centimetro' andType: 'distancia' andConversionRuleToReferenceUnit: [:anAmount | anAmount / 100] andConversionRuleFromReferenceUnit: [:anAmount | anAmount * 100].
	SimpleUnit createWithName: 'milimetro' andType: 'distancia' andConversionRuleToReferenceUnit: [:anAmount | anAmount / 1000] andConversionRuleFromReferenceUnit: [:anAmount | anAmount * 1000].! !

SimpleUnit initialize!