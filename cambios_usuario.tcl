while {1} {

    puts "\n================================"
    puts "      CAMBIOS DE USUARIO"
    puts "================================"
    puts "1. Cambiar nombre de usuario"
    puts "2. Cambiar contraseña"
    puts "0. Regresar"
    puts -nonewline "Seleccione una opción: "
    flush stdout

    gets stdin opcion

    switch $opcion {

        1 {

            puts -nonewline "\nUsuario actual: "
            flush stdout
            gets stdin actual

            if {$actual eq ""} {
                puts "\nError: Debe ingresar un usuario."
                continue
            }

            if {[catch {exec id $actual}]} {
                puts "\nError: El usuario no existe."
                continue
            }

            puts -nonewline "Nuevo nombre: "
            flush stdout
            gets stdin nuevo

            if {$nuevo eq ""} {
                puts "\nError: Nombre inválido."
                continue
            }

            if {![catch {exec id $nuevo}]} {
                puts "\nError: Ya existe un usuario con ese nombre."
                continue
            }

            if {[catch {exec sudo usermod -l $nuevo $actual} resultado]} {
                puts "\nError al modificar usuario:"
                puts $resultado
            } else {
                puts "\nUsuario modificado correctamente."
            }

            puts "\nPresione ENTER para continuar..."
            gets stdin pausa
        }

        2 {

            puts -nonewline "\nUsuario: "
            flush stdout
            gets stdin usuario

            if {$usuario eq ""} {
                puts "\nError: Debe ingresar un usuario."
                continue
            }

            if {[catch {exec id $usuario}]} {
                puts "\nError: El usuario no existe."
                continue
            }

            puts -nonewline "Nueva contraseña: "
            flush stdout
            gets stdin password

            if {[string length $password] < 4} {
                puts "\nError: La contraseña debe tener al menos 4 caracteres."
                continue
            }

            if {[catch {exec sh -c "echo '$usuario:$password' | sudo chpasswd"} resultado]} {
                puts "\nError al cambiar contraseña:"
                puts $resultado
            } else {
                puts "\nContraseña actualizada correctamente."
            }

            puts "\nPresione ENTER para continuar..."
            gets stdin pausa
        }

        0 {
            break
        }

        default {
            puts "\nOpción inválida."
            puts "\nPresione ENTER para continuar..."
            gets stdin pausa
        }
    }
}
