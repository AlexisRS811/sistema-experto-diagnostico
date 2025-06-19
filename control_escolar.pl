% --- Datos: Alumnos, Materias, Calificaciones ---
alumno(ana).     alumno(bruno).   alumno(carla).
alumno(david).   alumno(elsa).   % Declaramos los hechos como lo son alumnos, materias y calificaciones 

materia(administracion_de_redes).
materia(taller_de_investigacion_2).
materia(analisis_y_modelado_de_datos). % Declaramos nuestras materias en este caso seran 6
materia(programacion_web).
materia(sistemas_autonomos).
materia(base_de_datos).

calificacion(ana, administracion_de_redes, 9).    % Declararemos que calificacion obtuvo cada alumno segun la materia que corresponda
calificacion(ana, taller_de_investigacion_2, 10).
calificacion(ana, analisis_y_modelado_de_datos, 8).
calificacion(ana, programacion_web, 9).
calificacion(ana, sistemas_autonomos, 10).
calificacion(ana, base_de_datos, 9).
calificacion(bruno, administracion_de_redes, 6).
calificacion(bruno, taller_de_investigacion_2, 7).
calificacion(bruno, analisis_y_modelado_de_datos, 5).
calificacion(bruno, programacion_web, 6).
calificacion(bruno, sistemas_autonomos, 7).
calificacion(bruno, base_de_datos, 5).
calificacion(carla, administracion_de_redes, 10).
calificacion(carla, taller_de_investigacion_2, 10).
calificacion(carla, analisis_y_modelado_de_datos, 10).
calificacion(carla, programacion_web, 9).
calificacion(carla, sistemas_autonomos, 9).
calificacion(carla, base_de_datos, 10).
calificacion(david, administracion_de_redes, 7).
calificacion(david, taller_de_investigacion_2, 6).
calificacion(david, analisis_y_modelado_de_datos, 6).
calificacion(david, programacion_web, 5).
calificacion(david, sistemas_autonomos, 7).
calificacion(david, base_de_datos, 6).
calificacion(elsa, administracion_de_redes, 8).
calificacion(elsa, taller_de_investigacion_2, 8).
calificacion(elsa, analisis_y_modelado_de_datos, 9).
calificacion(elsa, programacion_web, 9).
calificacion(elsa, sistemas_autonomos, 10).
calificacion(elsa, base_de_datos, 9).

% --- Reglas ---
promedio(A, P) :- findall(C, calificacion(A, _, C), L), sumlist(L, S), length(L, N), N > 0, P is S / N.
estatus(A, aprobado) :- promedio(A, P), P >= 7.   % Aqui nos checara el status de cada alumno para ver si aprueban o reprueban.
estatus(A, reprobado) :- promedio(A, P), P < 7.   % En esta parte tenemos nuestras reglas las cuales suman
condicion(P, L, mayor) :- P > L.                  % las calificaciones del alumno y las promedian al final 
condicion(P, L, menor) :- P < L.      % esta condicion se usa para comparar si un promedio es menor o mayor a un limite que el usuario establecera manualmente al hacer consulta

% --- Menú ---
menu :- repeat,              % Con este repeat crearemos un bucle infinito hasta que una condicion lo detenga
    writeln('\n--- Sistema de Control Escolar ---'),
    writeln('1. Ver alumnos'),
    writeln('2. Ver calificaciones de un alumno'),       % Con writeln imprimimos en pantalla el menu 
    writeln('3. Ver promedio y estatus de un alumno'),
    writeln('4. Ver calificaciones por materia'),
    writeln('5. Ver alumnos por promedio'),
    writeln('6. Salir'),
    write('Opcion: '), read(O), opcion(O), O = 6, !.  % Utilizaremos read para leer opcion del ususario y opcion para ejecutarla

opcion(1) :- forall(alumno(A), writeln(A)).  % Esta opcion mostrara a todos los alumnos registrados 
opcion(2) :- write('Alumno: '), read(N), forall(calificacion(N, M, C), format('- ~w: ~w~n', [M, C])).  % Mostrara la calificacion del alumno.
opcion(3) :- write('Alumno: '), read(N), promedio(N, P), estatus(N, E), format('Promedio: ~2f ~nEstatus: ~w~n', [P, E]).  % Calcula su promedio y muestra su status si es aprobado o reprobado
opcion(4) :- write('Materia: '), read(M), forall(calificacion(A, M, C), format('- ~w: ~w~n', [A, C])).   % Muestra al alumno y la calificacion con esa materia 
opcion(5) :- write('Limite: '), read(L), write('Condicion (mayor/menor): '), read(C),   % Permite ver a los alumnos por rango de promedio 
             forall((alumno(A), promedio(A, P), condicion(P, L, C)), format('- ~w: ~2f~n', [A, P])).
opcion(6) :- writeln('Saliendo...'). % Por ultimo tenemos la opcion de salir, ya comentada tambien para salir del bucle del menu.
opcion(_) :- writeln('Opcion invalida.').
