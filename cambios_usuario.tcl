#!/usr/bin/tclsh

while {1} {
    exec clear >@stdout
    puts "\n\t================================"
    puts "\t       CAMBIOS DE USUARIO"
    puts "\t================================"
    puts "\t  1. Cambiar nombre de usuario"
    puts "\t  2. Cambiar contraseña"
    puts "\t  0. Regresar"
    puts -nonewline "\t  Seleccione una opción: "
    flush stdout

    gets stdin opcion

    switch $opcion {

        1 {

            puts -nonewline "\n\t  Usuario actual: "
            flush stdout
            gets stdin actual

            if {$actual eq ""} {
                puts "\n\t  Error: Debe ingresar un usuario."
                continue
            }

            if {[catch {exec id $actual}]} {
                puts "\n\t  Error: El usuario no existe."
                continue
            }

            puts -nonewline "\t  Nuevo nombre: "
            flush stdout
            gets stdin nuevo

            if {$nuevo eq ""} {
                puts "\nError: Nombre inválido."
                continue
            }

            if {![catch {exec id $nuevo}]} {
                puts "\n\t  Error: Ya existe un usuario con ese nombre."
                continue
            }

            if {[catch {exec sudo usermod -l $nuevo $actual} resultado]} {
                puts "\n\t  Error al modificar usuario:"
                puts $resultado
            } else {
                puts "\n\t  Usuario modificado correctamente."
            }

            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }

        2 {

            puts -nonewline "\n\t  Usuario: "
            flush stdout
            gets stdin usuario

            if {$usuario eq ""} {
                puts "\n\t  Error: Debe ingresar un usuario."
                continue
            }

            if {[catch {exec id $usuario}]} {
                puts "\n\t  Error: El usuario no existe."
                continue
            }

            puts -nonewline "\t  Nueva contraseña: "
            flush stdout
            gets stdin password

            if {[string length $password] < 4} {
                puts "\n\t  Error: La contraseña debe tener al menos 4 caracteres."
                continue
            }

            if {[catch {exec sh -c "echo '$usuario:$password' | sudo chpasswd"} resultado]} {
                puts "\n\t  Error al cambiar contraseña:"
                puts $resultado
            } else {
                puts "\n\t  Contraseña actualizada correctamente."
            }

            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }

        0 {
            break
        }

        default {
            puts "\n\t  Opción inválida."
            puts "\n\t  Presione ENTER para continuar..."
            gets stdin pausa
        }
    }
}
