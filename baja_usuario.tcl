#!/usr/bin/tclsh

exec clear >@stdout
puts "\n\t================================"
puts "\t       BAJA DE USUARIO"
puts "\t================================"

puts -nonewline "\t  Usuario a eliminar: "
flush stdout
gets stdin usuario

# Validar entrada
if {$usuario eq ""} {
    puts "\n\t  Error: Debe ingresar un usuario."

    puts "\n\t  Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Verificar si existe
if {[catch {exec id $usuario}]} {
    puts "\n\t  Error: El usuario no existe."

    puts "\n\t  Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Confirmación
puts -nonewline "\t  ¿Está seguro de eliminar '$usuario'? (s/n): "
flush stdout
gets stdin respuesta

if {[string tolower $respuesta] ne "s"} {
    puts "\n\t  Operación cancelada."

    puts "\n\t  Presione ENTER para continuar..."
    gets stdin pausa
    return
}

# Eliminar usuario y su directorio personal
if {[catch {exec sudo userdel -r $usuario} resultado]} {

    if {[catch {exec id $usuario}]} {
        puts "\n\t  Usuario eliminado correctamente."
    } else {
        puts "\n\t  Error al eliminar usuario:"
        puts $resultado
    }

} else {
    puts "\n\t  Usuario eliminado correctamente."
}

puts "\n\t  Presione ENTER para regresar al menú..."
gets stdin pausa
