import trabajoPractico1Objetos.*

class UserException inherits wollok.lang.Exception {
	constructor(_mensaje) = super(_mensaje)
}

class Personaje {
	var hechizoPreferido
	var artefactos
	var oro
	var valorBaseLucha
	
	constructor(unHechizo,_artefactos){
		hechizoPreferido = unHechizo
		artefactos = _artefactos
		oro = 100
		valorBaseLucha = 1 
	}
	method oro(nuevoOro){
		oro = nuevoOro
	}
	method oro(){
		return oro
	}
	method artefactos(){
		return artefactos
	}
	method nivelHechiceria(){
		return self.valorBaseHechizo()*hechizoPreferido.poder()+fuerzaOscura.valor()
	}
	method valorBaseHechizo(){
		return 3
	}
	method valorBaseLucha(valor){
		valorBaseLucha = valor
	}
	method valorBaseLucha(){
		return valorBaseLucha
	}
	method hechizoPreferido(hechizo){
		hechizoPreferido = hechizo
	}
	method habilidadLucha(){
		return self.valorBaseLucha() + artefactos.sum{artefacto=>artefacto.unidadesDeLucha(self)}
	}
	method agregarArtefacto(artefacto){
		artefactos.add(artefacto)
	}
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	method removerTodosLosArtefactos(){
		artefactos.clear()
	}
	method mayorHabilidadDeLucha(){
		return self.habilidadLucha() > self.nivelHechiceria()
	}
	method seCreePoderoso(){
		return hechizoPreferido.hechizoPoderoso()
	}
	method estaCargado(){
		return artefactos.size()>=5
	}
	method hechizoPreferido(){
		return hechizoPreferido
	}
	method conseguirOro(oroConseguido){
		oro += oroConseguido
	}
	method perderOro(oroPerdido){
		oro -= oroPerdido
	}
	method completarObjetivo(personaje){
		personaje.conseguirOro(10)
	}	
}

class Hechizo{
	
	constructor(){
		
	}
	method poder(){
		return 10
	}
	method hechizoPoderoso(){
		return self.poder()>15
	}
	method unidadesDeLucha(personaje){
		return self.poder()
	}
	method precio(personaje){
		return 10
	}
	method precioRefuerzo(armadura,personaje){
		return armadura.valorBase()+self.precio(personaje)
	}
}

class Logo inherits Hechizo{
	var multiplo
	var nombre
	
	constructor(unNombre, unMultiplo){
		nombre = unNombre
		multiplo = unMultiplo
	}
	
	method nombre(nuevoNombre){
		nombre = nuevoNombre
	}
	override method poder(){
		return nombre.size()*multiplo
	}
	override method precio(personaje){
		return self.poder()
	}
}

class Arma {
	method unidadesDeLucha(personaje){
		return 3
	}
	method precio(personaje){
		return 5*self.unidadesDeLucha(personaje)
	}
}

class Espada inherits Arma{}

class Hacha inherits Arma{}

class Lanza inherits Arma{}

class Mascara {
	var oscuridad
	var minimo
	
	constructor(unIndiceOscuridad){
		oscuridad = unIndiceOscuridad
		minimo = 4
	}
	method unidadesDeLucha(personaje){
			return minimo.max((fuerzaOscura.valor()/2)*oscuridad)
	}
	method minimo(valor){
		minimo = valor
	}		
}

class Armadura{
	var refuerzo
	var valorBase
	constructor(refuerzoNuevo,valorBaseLucha){
		refuerzo = refuerzoNuevo
		valorBase = valorBaseLucha
	}
	method unidadesDeLucha(personaje){
		return valorBase + refuerzo.unidadesDeLucha(personaje)
	}
	method refuerzo(nuevoRefuerzo){
		refuerzo = nuevoRefuerzo
	}
	method valorBase(){
		return valorBase
	}
	method precio(personaje){
		return refuerzo.precioRefuerzo(self,personaje)
	}
}

class CotaDeMalla{ 
	var unidadDeLucha
	constructor(nuevaUnidadDeLucha){
		unidadDeLucha = nuevaUnidadDeLucha
	}
	method unidadesDeLucha(personaje){
		return unidadDeLucha
	}
	method precioRefuerzo(armadura,personaje){
		return unidadDeLucha/2
	}
}

class LibroDeHechizos{
	var listaHechizos
	constructor(hechizos){
		listaHechizos = hechizos
	}
	method poder(){
		return listaHechizos.filter({hechizo=>hechizo.hechizoPoderoso()}).sum({hechizo=>hechizo.poder()})
	}
	method agregarAListaHechizos(hechizo){
		listaHechizos.add(hechizo)
	}
	method precio(personaje){
		return 10*self.cantidadDeHechizos()+listaHechizos.filter({hechizo=>hechizo.hechizoPoderoso()}).sum({hechizo=>hechizo.poder()})
	}
	method cantidadDeHechizos(){
		return listaHechizos.size()
	}
}
