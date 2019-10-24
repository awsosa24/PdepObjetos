/************** TP2 V2.0 ***************/

class Transporte{
    var tardanza
    var tipo /****/

    constructor(tardanzaTransporte, costoTransporte){
    	tardanza=tardanzaTransporte
    	costo=costoTransporte
    }
    
    method costo(){
    	return tipo.coste() /****/
    }

    method tardanza(){ /****/
        return tardanza
    }
}

/****/
object avion{
    var turbinas = []
    /*No se si se refiere a un(1) nivel de impulso por turbina o que cada turbina tiene una cant de impulso*/
    /*Supuse que es la segunda opcion*/

    method costo{
        return turbinas.sum()
    }
}

object micro{
    method costo(){
        return 5000
    }
}

object tren{
    method costo(){
        return 2300 * 0.62
    }
}

object barco{
    var probabilidadDeChocar

    method costo(){
        return 1000 * probabilidadDeChocar
    }
}


class Localidad{
    var equipaje
    var precio
    var kilometro
    var tipo /****/

    constructor (precioLocalidad,equipajeLocalidad,unKilometro){
		precio=precioLocalidad
		equipaje=equipajeLocalidad
        kilometro = unKilometro
	}
	
    method equipaje(){
        return equipaje
    } 
    
    method precio(){
        return precio
    }
	  
	method kilometro(){
        return kilometro
    }
    
    method esPeligroso(){
        return tipo.esPeligroso(equipaje) /****/
    }

    method esImportante(){
        return precio > 2000
    }

    method aplicarDescuento(descuento){
        precio = precio * (1 - descuento / 100)
    }   

    method agregarEquipaje(unEquipaje){
        equipaje.add(unEquipaje)
    }
}

/****/
object playa{
    method esPeligroso(equipaje){
        return false
    }
}

object montania{
    var altura

    method altura(unaAltura){
        altura = unaAltura
    }

    method esPeligroso(equipaje){
        return equipaje.contains("Vacuna Gripal") || equipaje.contains("Vacuna B") || altura > 5000
    }
}

object ciudadHistorica{
    method esPeligroso(equipaje){
        return equipaje.contains("Seguro de asistencia al viajero")
    }
}


class Viaje{
    var origen
    var destino
    var usuario
    var transporte

    constructor(unUsuario, unDestino, unTransporte){
        usuario = unUsuario
        origen = usuario.localidadDeorigen()
        destino = unDestino
        transporte = unTransporte
    }

    method precio(){
        return destino.precio() + self.kilometros() * transporte.costo()
    }

    method kilometros(){
        return (origen.kilometro() - destino.kilometro()).abs()
    }

}

class Usuario{
    var lugaresConocidos
    var saldo
    var seguidos
    var localidadDeorigen
    var kilometros = 0
    var perfil /****/

    constructor(lugaresUsuario, saldoUsuario, localidadUsuario){
    	lugaresConocidos = lugaresUsuario
    	saldo = saldoUsuario
    	localidadDeorigen = localidadUsuario
    }

    method viajar(unViaje){

        if(self.puedeViajar(unViaje.precio())){
            self.agregarDestino(unViaje.destino())
            saldo -= unViaje.costo()
            localidadDeorigen = unViaje.destino()
            kilometros += unViaje.kilometros()
        }
        else{
            //error.throwWithMessage("Dinero insuficiente para realizar el viaje")
            //Me tira un error de que no puede resolver la referencia
        }
    }

    method localidadDeorigen(){
        return localidadDeorigen
    }

	method puedeViajar(precioDeViaje){
		return precioDeViaje <= saldo 
	}
	
    method agregarDestino(destino){
        lugaresConocidos.add(destino)
    }
    
    method seguirA(unUsuario){
        seguidos.add(unUsuario)
        unUsuario.seguirA(self)
    }
    
    method lugaresConocidos(){
    	return lugaresConocidos
    }
    
    method saldo(){
    	return saldo
    }

    method perfil(nuevoPerfil){ /****/
        perfil = nuevoPerfil
    }

    method perfil(){ /****/
        return perfil
    }
}


object barrileteCosmico {
    var destinos = #{garlicSSea, silverSSea, lastToninas, goodAirs}
    var transportes = #{}

    method destinosMasImportantes(){
        return destinos.filter({destino => destino.esImportante() })
    }

    method aplicarDescuento(descuento){
        destinos.forEach({destino => destino.aplicarDescuento(descuento)})
        destinos.forEach({destino => destino.agregarEquipaje("Certificado de descuento")})
    }

    method esExtrema(){
        return destinos.any({destino => destino.esPeligroso()})
    }

    method destinos(){
        return destinos
    }
    
    method armarViaje(unUsuario, unaLocalidad){
        
        var unViaje = new Viaje(unUsuario, unaLocalidad, self.elegirTransporte(unUsuario)) /** ACA NOSE COMO TERMINARLO NI SI VA ACA **/
        unUsuario.viajar(unViaje) /*No me acuerdo si cuando armaba el viaje el usuario viajaba directamente o no */
    }

    method agregarTransporte(unTransporte){
        transportes.add(unTransporte)
    }
}

const garlicSSea  = new  Localidad(2500,#{"Caña de Pescar, Piloto"}, 344)
const silverSSea  = new  Localidad(1350,#{"Protector Solar", "Equipo de Buceo"}, 415)
const lastToninas = new  Localidad(3500,#{"Vacuna Gripal", "Vacuna B", "Necronomicon"}, 320)
const goodAirs    = new  Localidad(1500,#{"Cerveza", "Protector Solar"}, 0)

const pabloHari = new Usuario(#{lastToninas, goodAirs}, 1500+4150, goodAirs)