object garlicSea{
	const nombreDestino= "Garlic´s Sea"
	var precioDestino = 2500
	var equipajeImprescindible = #{"Cana de Pescar, Piloto"}
	
	method precioDestino(){ return precioDestino}
}
object silverSea{
	const nombreDestino= "Silver's Sea"
	var precioDestino = 1350
	var equipajeImprescindible = #{"Protector Solar", "Equipo de Buceo"}
	
	method precioDestino(){ return precioDestino}
}
object lastToninas{
	const nombreDestino= "Last Toninas"
	var precioDestino = 3500
	var equipajeImprescindible = #{"Vacuna Gripal", "Vacuna B", "Necronomicon"}
	
	method precioDestino(){ return precioDestino}
}
object goodAirs{
	const nombreDestino= "Good Airs"
	var precioDestino = 1500
	var equipajeImprescindible = #{"Cerveza", "Protector Solar"}
	
	method precioDestino(){ return precioDestino}
	method equipajeImprescindible(){return equipajeImprescindible }
	method equipajeImprescindible(nuevoEquipaje){equipajeImprescindible.add(nuevoEquipaje) }
	
	method agregarEquipajeImprescindible(nuevoEquipaje){
		self.equipajeImprescindible(nuevoEquipaje)
	}
}
// goodAirs.agregarEquipajeImprescindible("holaaaaaa")
object barrileteCosmico{
	
	var coleccionDestinos = [garlicSea, silverSea, lastToninas, goodAirs]
	
	method destinosMasImportantes(){
		return self.destinosDestacados()
	}
	method destinosDestacados(){
		return coleccionDestinos.filter({destino=> destino.precioDestino() > 2000})
	} //barrileteCosmico.destinosDestacados()
	
	method descuentosADestinos(){
		//coleccionDestinos.map({destino=> destino.precioDestino() })
		
		coleccionDestinos.map({destino=> 
			destino.agregarEquipajeImprescindible("Certificado de descuento")
		})
		
	}
}