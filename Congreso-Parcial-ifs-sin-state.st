!classDefinition: #Congresista category: #'Congreso-Parcial'!
Object subclass: #Congresista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:59:52'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	self subclassResponsibility. ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:59:55'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	^self dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo.  ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:59:57'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey enModo: modo
	^self dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo.   ! !

!Congresista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:59:59'!
dePartido: miPartido votaSegunPartidoDe: proyectoLey
	^miPartido = proyectoLey partidoAutor. ! !


!Congresista methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
esOportunista
	^false.! !


!classDefinition: #CongresistaInfluenciable category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaInfluenciable
	instanceVariableNames: 'leyesAVotarEnContra leyesAVotarAFavor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaInfluenciable methodsFor: 'initialization' stamp: 'JFGO 3/2/2026 00:00:00'!
initialize
	leyesAVotarEnContra := OrderedCollection new.
	leyesAVotarAFavor := OrderedCollection new.! !


!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:51'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	(leyesAVotarEnContra includes: proyectoLey) ifTrue: [^false].
	(leyesAVotarAFavor includes: proyectoLey) ifTrue: [^true].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaInfluenciable methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:53'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	"Ignora influencia en leyes constitucionales"
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !


!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/2/2026 00:00:00'!
votarAFavor: proyectoLey
	leyesAVotarAFavor add: proyectoLey.! !

!CongresistaInfluenciable methodsFor: 'influencia' stamp: 'JFGO 3/2/2026 00:00:00'!
votarEnContra: proyectoLey
	leyesAVotarEnContra add: proyectoLey.! !


!classDefinition: #CongresistaLeal category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaLeal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaLeal methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:44'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !


!classDefinition: #CongresistaOportunista category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaOportunista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:51:00'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	"El modo determina como vota el oportunista"
	^modo votoOportunistaDe: self delPartido: miPartido paraProyecto: proyectoLey! !

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:55:12'!
votoEnModoEmergenciadePartido: miPartido votaAFavorDe: proyectoLey 
	"En emergencia, los oportunistas siempre votan a favor"
	^true. 
	! !

!CongresistaOportunista methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:53:29'!
votoEnModoNormaldePartido: miPartido votaAFavorDe: proyectoLey 
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. 
	! !


!CongresistaOportunista methodsFor: 'testing' stamp: 'JFGO 3/2/2026 00:00:00'!
esOportunista
	^true.! !


!classDefinition: #CongresistaPaladin category: #'Congreso-Parcial'!
Congresista subclass: #CongresistaPaladin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:59:30'!
dePartido: miPartido votaAFavorDe: proyectoLey enModo: modo
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:29'!
dePartido: miPartido votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo
	"Si el partido supera 75%, vota en contra de su partido"
	proporcion > (3/4) ifTrue: [
		^(self dePartido: miPartido votaSegunPartidoDe: proyectoLey) not.
	].
	^self dePartido: miPartido votaSegunPartidoDe: proyectoLey. ! !

!CongresistaPaladin methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:36'!
dePartido: miPartido votaAFavorDePresupuesto: proyectoLey enModo: modo
	"Paladin siempre vota a favor de presupuestos"
	^true. ! !


!classDefinition: #Congreso category: #'Congreso-Parcial'!
Object subclass: #Congreso
	instanceVariableNames: 'partidoAzul partidoRojo totalCongresistas modo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Congreso methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:58:25'!
initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	partidoAzul := unPartidoAzul.
	partidoRojo := unPartidoRojo.
	totalCongresistas := partidoAzul totalCongresistas + partidoRojo totalCongresistas.
	modo := ModoNormal new. ! !


!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/9/2026 19:26:06'!
modo
	^modo. ! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/9/2026 19:58:16'!
partidoOpuestoA: unPartido

	unPartido = partidoAzul ifTrue: [^partidoRojo].
	^partidoAzul.! !

!Congreso methodsFor: 'accessing' stamp: 'JFGO 3/9/2026 19:57:51'!
totalCongresistas
	^totalCongresistas. ! !


!Congreso methodsFor: 'testing' stamp: 'JFGO 3/9/2026 19:58:28'!
estaEnEmergencia
	^modo estaEnEmergencia. ! !


!Congreso methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:57:48'!
votar: proyectoLey
	"Double dispatch: el proyecto de ley sabe como votarse"
	^proyectoLey votarEn: self. ! !


!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/9/2026 19:24:27'!
votarConstitucional: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: totalCongresistas enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self registrarResultadoDeVotacion: votacion siRechazado: [].
	
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/9/2026 19:25:03'!
votarOrdinaria: proyectoLey
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDe: proyectoLey enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDe: proyectoLey enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self registrarResultadoDeVotacion: votacion siRechazado: [
				modo moverOportunistaDelPartido: (votacion proyectoLey partidoAutor) enCongreso: self.
			].
	^votacion.! !

!Congreso methodsFor: 'votacion - double dispatch' stamp: 'JFGO 3/9/2026 19:25:35'!
votarPresupuesto: proyectoLey
"En estos dispatchs, mucho codigo repetido"
	| congresistasAFavor votacion |
	congresistasAFavor := partidoAzul congresistasAFavorDePresupuesto: proyectoLey enModo: modo.
	congresistasAFavor addAll: (partidoRojo congresistasAFavorDePresupuesto: proyectoLey enModo: modo).
	votacion := Votacion paraProyectoLey: proyectoLey conVotosAFavorDe: congresistasAFavor sobreUnTotalDe: totalCongresistas.
	self registrarResultadoDeVotacion: votacion siRechazado: [
				modo moverOportunistaDelPartido: (votacion proyectoLey partidoAutor) enCongreso: self.
			].
	^votacion.! !


!Congreso methodsFor: 'privado' stamp: 'JFGO 3/9/2026 15:58:45'!
moverPrimerOportunistaDelPartido: partidoQuePerdioLaVotacion
	
		
	partidoQuePerdioLaVotacion oportunistaCambiaDePartidoEn: self.! !

!Congreso methodsFor: 'privado' stamp: 'JFGO 3/9/2026 19:24:08'!
registrarResultadoDeVotacion: votacion siRechazado: bloqueSiVotacionRechazada
	votacion proyectoAprobado
		ifTrue: [modo := modo registrarAprobacion]
		ifFalse: [
			modo := modo registrarRechazo.
			bloqueSiVotacionRechazada value.
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Congreso class' category: #'Congreso-Parcial'!
Congreso class
	instanceVariableNames: ''!

!Congreso class methodsFor: 'instance creation' stamp: 'JFGO 3/9/2026 19:58:39'!
conPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo
	(unPartidoAzul totalCongresistas + unPartidoRojo totalCongresistas) even
		ifTrue: [self error: self congresistasPares].
	^self new initializeConPartidoAzul: unPartidoAzul conPartidoRojo: unPartidoRojo. ! !


!Congreso class methodsFor: 'error messages' stamp: 'JFGO 3/9/2026 19:58:35'!
congresistasPares
	^'Deben ser impares'. ! !


!classDefinition: #FuncionamientoCongreso category: #'Congreso-Parcial'!
Object subclass: #FuncionamientoCongreso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!FuncionamientoCongreso methodsFor: 'testing' stamp: 'JFGO 3/9/2026 19:46:55'!
estaEnEmergencia
	self subclassResponsibility. ! !


!FuncionamientoCongreso methodsFor: 'votacion oportunista' stamp: 'JFGO 3/9/2026 19:56:23'!
votoOportunistaDe: unOportunista delPartido: partido paraProyecto: proyectoLey
	self subclassResponsibility. ! !


!FuncionamientoCongreso methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:47:01'!
registrarAprobacion
	self subclassResponsibility. ! !

!FuncionamientoCongreso methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:47:03'!
registrarRechazo
	self subclassResponsibility. ! !


!FuncionamientoCongreso methodsFor: 'acciones' stamp: 'JFGO 3/9/2026 19:46:59'!
moverOportunistaDelPartido: partido enCongreso: congreso
	self subclassResponsibility. ! !


!classDefinition: #ModoEmergencia category: #'Congreso-Parcial'!
FuncionamientoCongreso subclass: #ModoEmergencia
	instanceVariableNames: 'aprobacionesConsecutivas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoEmergencia methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:47:27'!
initialize
	aprobacionesConsecutivas := 0. ! !


!ModoEmergencia methodsFor: 'testing' stamp: 'JFGO 3/9/2026 19:47:29'!
estaEnEmergencia
	^true. ! !


!ModoEmergencia methodsFor: 'votacion oportunista' stamp: 'JFGO 3/9/2026 19:56:42'!
votoOportunistaDe: unOportunista delPartido: partido paraProyecto: proyectoLey
	^unOportunista votoEnModoEmergenciadePartido: partido votaAFavorDe: proyectoLey .! !


!ModoEmergencia methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:47:19'!
registrarAprobacion
	aprobacionesConsecutivas := aprobacionesConsecutivas + 1.
	aprobacionesConsecutivas >= 2 ifTrue: [^ModoNormal new]. 
	^self. ! !

!ModoEmergencia methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:47:16'!
registrarRechazo
	aprobacionesConsecutivas := 0. 
	^self. ! !


!ModoEmergencia methodsFor: 'acciones' stamp: 'JFGO 3/9/2026 19:47:21'!
moverOportunistaDelPartido: partido enCongreso: congreso
	"En emergencia no se mueven oportunistas"
	^self. ! !


!classDefinition: #ModoNormal category: #'Congreso-Parcial'!
FuncionamientoCongreso subclass: #ModoNormal
	instanceVariableNames: 'rechazosConsecutivos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ModoNormal methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:47:42'!
initialize
	rechazosConsecutivos := 0. ! !


!ModoNormal methodsFor: 'testing' stamp: 'JFGO 3/9/2026 19:47:39'!
estaEnEmergencia
	^false. ! !


!ModoNormal methodsFor: 'votacion oportunista' stamp: 'JFGO 3/9/2026 19:54:07'!
votoOportunistaDe: unOportunista delPartido: partido paraProyecto: proyectoLey
	^unOportunista votoEnModoNormaldePartido: partido votaAFavorDe: proyectoLey .
	! !


!ModoNormal methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:47:47'!
registrarAprobacion
	rechazosConsecutivos := 0.
	^self.  ! !

!ModoNormal methodsFor: 'transiciones' stamp: 'JFGO 3/9/2026 19:16:19'!
registrarRechazo
	rechazosConsecutivos := rechazosConsecutivos + 1.
	rechazosConsecutivos >= 4 ifTrue: [^ModoEmergencia new].
	^self. ! !


!ModoNormal methodsFor: 'acciones' stamp: 'JFGO 3/9/2026 19:47:44'!
moverOportunistaDelPartido: partido enCongreso: congreso
	"En modo normal, se mueve el oportunista"
	congreso moverPrimerOportunistaDelPartido: partido. ! !


!classDefinition: #Partido category: #'Congreso-Parcial'!
Object subclass: #Partido
	instanceVariableNames: 'congresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Partido methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:42:20'!
initializeConCongresistas: unosCongresistas
	congresistas := unosCongresistas . ! !


!Partido methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:43:38'!
congresistasAFavorDe: proyectoLey enModo: modo
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDe: proyectoLey enModo: modo].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:27:07'!
congresistasAFavorDeConstitucional: proyectoLey conTotalCongreso: total enModo: modo
	"Cada congresista sabe como votar constitucional polimorficamente"
	| proporcion |
	proporcion := self totalCongresistas / total.
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDeConstitucional: proyectoLey conProporcionPartido: proporcion enModo: modo].! !

!Partido methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:43:25'!
congresistasAFavorDePresupuesto: proyectoLey enModo: modo
	"Cada congresista sabe como votar presupuesto polimorficamente"
	^congresistas select: [:congresista | congresista dePartido: self votaAFavorDePresupuesto: proyectoLey enModo: modo].! !


!Partido methodsFor: 'oportunistas' stamp: 'JFGO 3/9/2026 19:43:09'!
oportunistaCambiaDePartidoEn: unCongreso
	| partidoDestino primerOportunista |
	primerOportunista := congresistas detect: [:congresista | congresista esOportunista] ifNone: [^self.].
	partidoDestino := unCongreso partidoOpuestoA: self.
	self removerCongresista: primerOportunista.
	partidoDestino agregarCongresista: primerOportunista.
	^self.! !


!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/2/2026 00:00:00'!
agregarCongresista: unCongresista
	congresistas add: unCongresista.! !

!Partido methodsFor: 'modificacion' stamp: 'JFGO 3/9/2026 19:44:21'!
removerCongresista: unCongresista
	congresistas remove: unCongresista ifAbsent: [self shouldNotHappenBecause: 'Es un ambiente controlado de congresistas']. ! !


!Partido methodsFor: 'accessing' stamp: 'JFGO 3/9/2026 19:41:59'!
totalCongresistas
	^congresistas size. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Partido class' category: #'Congreso-Parcial'!
Partido class
	instanceVariableNames: ''!

!Partido class methodsFor: 'instance creation' stamp: 'JFGO 3/9/2026 19:44:43'!
conCongresistas: unosCongresistas
	unosCongresistas ifEmpty: [self error: self congresistasInsuficientes].
	^self new initializeConCongresistas: unosCongresistas. ! !


!Partido class methodsFor: 'error messages' stamp: 'JFGO 3/9/2026 19:44:40'!
congresistasInsuficientes
	^'Debe haber al menos uno.'. ! !


!classDefinition: #ProyectoLey category: #'Congreso-Parcial'!
Object subclass: #ProyectoLey
	instanceVariableNames: 'partidoAutor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLey methodsFor: 'aprobacion' stamp: 'JFGO 3/9/2026 19:37:46'!
proporcionParaSerAprobado
	self subclassResponsibility.  ! !


!ProyectoLey methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:37:49'!
votarEn: congreso
	self subclassResponsibility.  ! !


!ProyectoLey methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:37:41'!
initializeDePartido: unPartido
	partidoAutor := unPartido. ! !


!ProyectoLey methodsFor: 'accessing' stamp: 'JFGO 3/9/2026 19:37:44'!
partidoAutor
	^partidoAutor. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProyectoLey class' category: #'Congreso-Parcial'!
ProyectoLey class
	instanceVariableNames: ''!

!ProyectoLey class methodsFor: 'instance creation' stamp: 'JFGO 3/9/2026 19:34:11'!
dePartido: unPartido
	^self new initializeDePartido: unPartido. ! !


!classDefinition: #ProyectoLeyConstitucional category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyConstitucional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyConstitucional methodsFor: 'aprobacion' stamp: 'JFGO 3/9/2026 19:34:01'!
proporcionParaSerAprobado
	^2/3. ! !


!ProyectoLeyConstitucional methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:33:57'!
votarEn: congreso
	^congreso votarConstitucional: self. ! !


!classDefinition: #ProyectoLeyOrdinaria category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyOrdinaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyOrdinaria methodsFor: 'aprobacion' stamp: 'JFGO 3/9/2026 19:33:48'!
proporcionParaSerAprobado
	^1/2. ! !


!ProyectoLeyOrdinaria methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:33:51'!
votarEn: congreso
	^congreso votarOrdinaria: self. ! !


!classDefinition: #ProyectoLeyPresupuesto category: #'Congreso-Parcial'!
ProyectoLey subclass: #ProyectoLeyPresupuesto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!ProyectoLeyPresupuesto methodsFor: 'aprobacion' stamp: 'JFGO 3/9/2026 19:33:35'!
proporcionParaSerAprobado
	^3/5. ! !


!ProyectoLeyPresupuesto methodsFor: 'votacion' stamp: 'JFGO 3/9/2026 19:33:30'!
votarEn: congreso
	^congreso votarPresupuesto: self. ! !


!classDefinition: #Votacion category: #'Congreso-Parcial'!
Object subclass: #Votacion
	instanceVariableNames: 'proyectoLey congresistasAFavor totalCongresistas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!Votacion methodsFor: 'initialization' stamp: 'JFGO 3/9/2026 19:32:32'!
initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: unTotalDeCongresistas
	proyectoLey := unProyectoLey.
	congresistasAFavor := unaColeccionDeCongresistas.
	totalCongresistas := unTotalDeCongresistas.
	! !


!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/9/2026 19:30:53'!
conVotoAFavorDe: unCongresista
	^congresistasAFavor includes: unCongresista. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/9/2026 19:30:59'!
conVotoEnContraDe: unCongresista
	^(self conVotoAFavorDe: unCongresista) not. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/9/2026 19:42:49'!
proyectoAprobado
	| votosNecesarios |
	votosNecesarios := totalCongresistas * proyectoLey proporcionParaSerAprobado. 
	^self votosAFavor >= votosNecesarios. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/9/2026 19:32:03'!
votosAFavor
	^congresistasAFavor  size. ! !

!Votacion methodsFor: 'resultado' stamp: 'JFGO 3/9/2026 19:32:20'!
votosEnContra
	^totalCongresistas - self votosAFavor . ! !


!Votacion methodsFor: 'accessing' stamp: 'JFGO 3/2/2026 00:00:00'!
proyectoLey
	^proyectoLey.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Votacion class' category: #'Congreso-Parcial'!
Votacion class
	instanceVariableNames: ''!

!Votacion class methodsFor: 'instance creation' stamp: 'JFGO 3/9/2026 19:33:10'!
paraProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: totalDeCongresistas
	^self new initializeParaProyectoLey: unProyectoLey conVotosAFavorDe: unaColeccionDeCongresistas sobreUnTotalDe: totalDeCongresistas.! !


!classDefinition: #CongresoTest category: #'Congreso-Parcial'!
TestCase subclass: #CongresoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Congreso-Parcial'!

!CongresoTest methodsFor: '00 - validaciones' stamp: 'JFGO 3/9/2026 15:59:41'!
test01PartidoDebeTenerAlMenosUnCongresista
	self should: [
		Partido conCongresistas: OrderedCollection new.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Partido congresistasInsuficientes.
	]. ! !

!CongresoTest methodsFor: '00 - validaciones' stamp: 'JFGO 3/9/2026 15:59:43'!
test02CongresoDebeTenerUnaCantidadImparTotalDeCongresistas
	| partidoAzul partidoRojo |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	self should: [
		Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	] raise: Error - MessageNotUnderstood
	withExceptionDo: [:e |
		self assert: e messageText equals: Congreso congresistasPares.
	]. ! !


!CongresoTest methodsFor: '01 - proyectos ordinarios' stamp: 'JFGO 3/9/2026 16:01:52'!
test03ProyectoLeyOrdinariaPresentadoPorPartidoMayoritarioEsAprobadoMayoriaSimple
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: '01 - proyectos ordinarios' stamp: 'JFGO 3/9/2026 16:02:24'!
test04ProyectoLeyOrdinariaPresentadoPorPartidoMinoritarioEsRechazadoMayoriaSimple
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoRojo.
	
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 2.
	self assert: votacion votosEnContra equals: 3.! !


!CongresoTest methodsFor: '01 - proyectos constitucionales' stamp: 'JFGO 3/9/2026 16:03:19'!
test05ProyectoLeyConstitucionalPresentadoPorPartidoMayoritarioEsRechazadoSinDosTercios
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !

!CongresoTest methodsFor: '01 - proyectos constitucionales' stamp: 'JFGO 3/9/2026 16:03:32'!
test06ProyectoLeyConstitucionalEsAprobadoConDosTercios
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.! !


!CongresoTest methodsFor: '01 - proyectos presupuesto' stamp: 'JFGO 3/9/2026 16:04:20'!
test07ProyectoLeyPresupuestoEsRechazadoSinTresQuintos
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 4.! !

!CongresoTest methodsFor: '01 - proyectos presupuesto' stamp: 'JFGO 3/9/2026 16:04:27'!
test08ProyectoLeyPresupuestoEsAprobadoConTresQuintos
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.! !


!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/9/2026 16:06:56'!
test09LeyOrdinariaRechazadaMuevePrimerOportunistaDelPartidoProponente
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	"Luego de Perder votacion, el oportunista cambia de bando y cambia composicion del congreso"
	self assert: partidoAzul totalCongresistas equals: 1.
	self assert: partidoRojo totalCongresistas equals: 4.! !

!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/9/2026 16:07:13'!
test10LeyOrdinariaAprobadaNoMueveOportunista
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	
	
	self assert: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 3.
	self assert: partidoRojo totalCongresistas equals: 2.! !

!CongresoTest methodsFor: '02 - ley ordinaria - oportunista' stamp: 'JFGO 3/9/2026 16:07:30'!
test11LeyOrdinariaRechazadaSinOportunistasNoMueveNadie
	| partidoAzul partidoRojo congreso proyectoLey votacion |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !


!CongresoTest methodsFor: '02 - ley presupuesto - paladin' stamp: 'JFGO 3/9/2026 19:08:03'!
test12LeyPresupuestoPaladinesSiempreVotanAFavor
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinRojo |
	paladinRojo := CongresistaPaladin new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: paladinRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	
	votacion := congreso votar: proyectoLey.
	
	self assert: votacion votosAFavor equals: 3.
	self assert: votacion votosEnContra equals: 2.
	self assert: (votacion conVotoAFavorDe: paladinRojo).
	self assert: votacion proyectoAprobado.! !

!CongresoTest methodsFor: '02 - ley presupuesto - paladin' stamp: 'JFGO 3/9/2026 19:08:17'!
test13LeyPresupuestoRechazadaMuevePrimerOportunista
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyPresupuesto dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	votacion := congreso votar: proyectoLey.
	
	self deny: votacion proyectoAprobado.
	self assert: partidoAzul totalCongresistas equals: 1.
	self assert: partidoRojo totalCongresistas equals: 4.! !


!CongresoTest methodsFor: '02 - ley constitucional - influenciable' stamp: 'JFGO 3/9/2026 19:08:50'!
test14LeyConstitucionalInfluenciableIgnoraInfluencia
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: influenciable).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	influenciable votarEnContra: proyectoLey.
	
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: influenciable).
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.
	self assert: votacion proyectoAprobado.! !


!CongresoTest methodsFor: '02 - ley constitucional - paladin' stamp: 'JFGO 3/9/2026 19:12:14'!
test15LeyConstitucionalPaladinVotaContraPartidoSiSupera75Porciento
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinAzul congresistasAzules |
	paladinAzul := CongresistaPaladin new.
	congresistasAzules := (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congresistasAzules add: paladinAzul.
	partidoAzul := Partido conCongresistas: congresistasAzules.
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoEnContraDe: paladinAzul).
	self assert: votacion votosAFavor equals: 6.
	self assert: votacion votosEnContra equals: 3.! !

!CongresoTest methodsFor: '02 - ley constitucional - paladin' stamp: 'JFGO 3/9/2026 19:29:16'!
test16LeyConstitucionalPaladinVotaConPartidoSiNoSupera75Porciento
	| partidoAzul partidoRojo congreso proyectoLey votacion paladinAzul |
	paladinAzul := CongresistaPaladin new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new with: paladinAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	
	self assert: (votacion conVotoAFavorDe: paladinAzul).
	self assert: votacion votosAFavor equals: 5.
	self assert: votacion votosEnContra equals: 2.! !


!CongresoTest methodsFor: '02 - ley constitucional - oportunista' stamp: 'JFGO 3/9/2026 19:28:23'!
test17LeyConstitucionalNoMueveOportunistaAunqueSeRechace
	| partidoAzul partidoRojo congreso proyectoLey votacion oportunista |
	oportunista := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunista).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyConstitucional dePartido: partidoAzul.
	self assert: partidoAzul totalCongresistas equals: 2.
	votacion := congreso votar: proyectoLey.
	
	self deny: votacion proyectoAprobado.
	"La composicion se mantiene"
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !


!CongresoTest methodsFor: '02 - ley ordinaria - influenciable' stamp: 'JFGO 3/9/2026 19:30:16'!
test18LeyOrdinariaInfluenciableSiEsInfluenciado
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: influenciable).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	influenciable votarEnContra: proyectoLey.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoEnContraDe: influenciable).
	self deny: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 1.
	self assert: votacion votosEnContra equals: 2. ! !


!CongresoTest methodsFor: '02 - ley ordinaria - influenciable a favor' stamp: 'JFGO 3/9/2026 19:30:20'!
test19LeyOrdinariaInfluenciableVotaAFavorSiEsInfluenciado
	| partidoAzul partidoRojo congreso proyectoLey votacion influenciable |
	influenciable := CongresistaInfluenciable new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: influenciable).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	influenciable votarAFavor: proyectoLey.
	votacion := congreso votar: proyectoLey.
	self assert: (votacion conVotoAFavorDe: influenciable).
	
	self assert: votacion proyectoAprobado.
	self assert: votacion votosAFavor equals: 4.
	self assert: votacion votosEnContra equals: 1.! !


!CongresoTest methodsFor: '03 - modo emergencia' stamp: 'JFGO 3/9/2026 19:29:58'!
test21CuatroVotacionesRechazadasActivanModoEmergencia
	| partidoAzul partidoRojo congreso proyectoLey |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	congreso votar: proyectoLey.
	congreso votar: proyectoLey.
	congreso votar: proyectoLey.
	self deny: congreso estaEnEmergencia.
	congreso votar: proyectoLey.
	
	self assert: congreso estaEnEmergencia.! !

!CongresoTest methodsFor: '03 - modo emergencia' stamp: 'JFGO 3/9/2026 19:30:01'!
test22DosVotacionesAprobadasDesactivanModoEmergencia
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLeyAprobado |
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	proyectoLeyAprobado := ProyectoLeyOrdinaria dePartido: partidoRojo.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	congreso votar: proyectoLeyRechazado.
	
	self assert: congreso estaEnEmergencia.
	congreso votar: proyectoLeyAprobado.
	self assert: congreso estaEnEmergencia.
	congreso votar: proyectoLeyAprobado.
	self deny: congreso estaEnEmergencia.! !

!CongresoTest methodsFor: '03 - modo emergencia' stamp: 'JFGO 3/9/2026 19:30:04'!
test23EnEmergenciaOportunistasVotanAFavor
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion unOportunistaRojo otroOportunistaRojo |
	unOportunistaRojo := CongresistaOportunista new.
	otroOportunistaRojo := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: otroOportunistaRojo with: unOportunistaRojo).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyOrdinaria dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	self assert: congreso estaEnEmergencia.
	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	
	self assert: (votacion conVotoAFavorDe: unOportunistaRojo).
	self assert: (votacion conVotoAFavorDe: otroOportunistaRojo).
	self assert: votacion votosAFavor equals: 4.
	self assert: votacion votosEnContra equals: 1.! !

!CongresoTest methodsFor: '03 - modo emergencia' stamp: 'JFGO 3/9/2026 19:30:10'!
test24EnEmergenciaOportunistasNoCambianDePartido
	| partidoAzul partidoRojo congreso proyectoLeyRechazado proyectoLey votacion oportunistaAzul |
	oportunistaAzul := CongresistaOportunista new.
	partidoAzul := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: oportunistaAzul).
	partidoRojo := Partido conCongresistas: (OrderedCollection with: CongresistaLeal new with: CongresistaLeal new with: CongresistaLeal new).
	congreso := Congreso conPartidoAzul: partidoAzul conPartidoRojo: partidoRojo.
	proyectoLeyRechazado := ProyectoLeyConstitucional dePartido: partidoAzul.
	4 timesRepeat: [congreso votar: proyectoLeyRechazado].
	"Como la ley es constitucional, el oportunistaAzul no cambia de partido"
	self assert: congreso estaEnEmergencia.
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.

	proyectoLey := ProyectoLeyOrdinaria dePartido: partidoAzul.
	votacion := congreso votar: proyectoLey.
	self deny: votacion proyectoAprobado.
	
	"En emergencia no se mueve el oportunista aunque se rechace"
	self assert: partidoAzul totalCongresistas equals: 2.
	self assert: partidoRojo totalCongresistas equals: 3.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 25 135 8 17 56 62 57 53 56 63 53 56 57 63 53 56 17 81 92 83 80 78 86 90 91 53 116 122 111 118 116 108 53 117 108 123 17 81 92 83 80 78 86 90 91 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 59 65 57 57 65 58 64 53 59 56 57 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 59 59 59 56 64 53 122 123 17 58 56 55 64 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 59 65 59 55 65 57 60 53 58 59 57 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 64 62 55 57 58 53 122 123 17 56 63 56 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 59 91 56 61 65 55 56 65 57 64 53 58 61 59 60 58 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 60 60 56 57 59 53 122 123 17 57 57 59 59 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 55 64 65 60 57 65 58 60 53 60 55 61 55 55 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 56 64 61 57 59 53 122 123 17 57 58 63 61 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 56 56 65 56 64 65 56 64 53 61 62 59 55 55 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 64 55 61 57 57 53 122 123 17 57 56 63 63 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 60 91 56 59 65 60 56 65 60 61 53 64 58 63 62 62 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 119 104 121 106 112 104 115 57 99 107 118 117 108 99 56 61 55 57 58 53 122 123 17 57 63 56 56 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 55 65 56 63 53 58 63 64 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 106 52 89 108 106 124 52 77 112 117 104 115 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 60 65 60 56 53 58 60 63 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 74 52 89 108 106 124 119 108 121 104 123 118 121 112 118 52 86 121 112 110 112 117 104 115 53 122 123 17 56 58 61 57 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 55 64 91 56 62 65 56 61 65 56 60 53 55 60 57 57 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 57 55 57 60 52 57 106 52 89 108 106 124 52 77 112 117 104 115 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 55 64 91 55 64 65 60 64 65 57 60 53 57 57 64 58 64 60 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 75 118 126 117 115 118 104 107 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 52 112 109 122 52 122 112 117 52 122 123 104 123 108 53 122 123 17 58 64 57 62 61 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 57 52 57 57 91 56 61 65 56 62 65 58 61 53 58 62 59 62 62 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 106 52 89 108 106 124 53 122 123 17 58 62 63 58 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 55 58 91 56 58 65 57 57 65 57 61 53 61 55 61 63 62 59 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 42 52 42 87 104 121 106 112 104 115 53 122 123 17 60 57 58 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 55 58 91 56 58 65 57 57 65 59 63 53 59 57 57 63 62 59 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 60 57 55 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 55 61 91 56 57 65 59 61 65 59 55 53 62 63 62 58 61 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 56 57 62 57 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 57 52 57 59 91 56 62 65 56 60 65 56 62 53 64 58 63 57 55 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 56 63 59 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 56 55 91 56 62 65 57 59 65 56 55 53 61 62 55 63 57 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 53 122 123 17 59 55 60 63 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 58 52 56 63 91 56 62 65 60 62 65 56 58 53 57 56 55 55 55 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 62 61 59 56 102 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 74 118 117 110 121 108 122 118 52 87 104 121 106 112 104 115 52 112 109 122 52 122 112 117 52 122 123 104 123 108 53 122 123 17 59 55 60 63 56 17 52 52 52 52 52 52 52 52 52 52 17 17))!