%%%%%% HECHOS
% instancia_de(Objeto, Clase)
instancia_de(el_padrino, pelicula).
instancia_de(pulp_fiction, pelicula).
instancia_de(interstellar, pelicula).
instancia_de(inception, pelicula).
instancia_de(the_dark_knight, pelicula).
instancia_de(leonardo_dicaprio, actor).
instancia_de(robert_de_niro, actor).
instancia_de(meryl_streep, actor).
instancia_de(christopher_nolan, director).
instancia_de(quentin_tarantino, director).
instancia_de(francis_ford_coppola, director).
instancia_de(james_cameron, director).
instancia_de(drama, genero).
instancia_de(thriller, genero).
instancia_de(ciencia_ficcion, genero).
instancia_de(accion, genero).
instancia_de(animacion, genero).
instancia_de(aventura, genero).
instancia_de(oscar_mejor_pelicula, premio).
instancia_de(oscar_mejor_actor, premio).
instancia_de(oscar_mejor_director, premio).
instancia_de(globo_oro, premio).
instancia_de(bafta, premio).
instancia_de(el_rey_leon, pelicula).
instancia_de(frozen, pelicula).
instancia_de(mulan, pelicula).
instancia_de(toy_story, pelicula).
instancia_de(aladdin, pelicula).
instancia_de(walt_disney, productor).

% subclase(Subclase, Clase)
subclase_de(pelicula, obra_audiovisual).
subclase_de(obra_audiovisual, produccion_artistica).
subclase_de(actor, persona).
subclase_de(director, persona).
subclase_de(productor, persona).
subclase_de(genero, categoria).
subclase_de(premio, reconocimiento).

% tiene_propiedad(Objeto, propiedad, Valor)
tiene_propiedad(el_padrino, dirigido_por, francis_ford_coppola).
tiene_propiedad(el_padrino, pertenece_a, drama).
tiene_propiedad(el_padrino, gano, oscar_mejor_pelicula).
tiene_propiedad(pulp_fiction, dirigido_por, quentin_tarantino).
tiene_propiedad(pulp_fiction, pertenece_a, thriller).
tiene_propiedad(interstellar, dirigido_por, christopher_nolan).
tiene_propiedad(interstellar, pertenece_a, ciencia_ficcion).
tiene_propiedad(inception, dirigido_por, christopher_nolan).
tiene_propiedad(inception, pertenece_a, thriller).
tiene_propiedad(the_dark_knight, dirigido_por, christopher_nolan).
tiene_propiedad(the_dark_knight, pertenece_a, accion).
tiene_propiedad(leonardo_dicaprio, actuo_en, inception).
tiene_propiedad(robert_de_niro, actuo_en, el_padrino).
tiene_propiedad(meryl_streep, actuo_en, the_post).
tiene_propiedad(christopher_nolan, gano, oscar_mejor_director).
tiene_propiedad(quentin_tarantino, gano, globo_oro).
tiene_propiedad(francis_ford_coppola, gano, bafta).
tiene_propiedad(james_cameron, gano, oscar_mejor_director).
tiene_propiedad(leonardo_dicaprio, gano, oscar_mejor_actor).
tiene_propiedad(robert_de_niro, gano, globo_oro).
tiene_propiedad(meryl_streep, gano, bafta).
tiene_propiedad(el_rey_leon, dirigido_por, roger_allers).
tiene_propiedad(el_rey_leon, pertenece_a, animacion).
tiene_propiedad(el_rey_leon, gano, oscar_mejor_pelicula).
tiene_propiedad(frozen, dirigido_por, chris_buck).
tiene_propiedad(frozen, pertenece_a, animacion).
tiene_propiedad(frozen, gano, oscar_mejor_pelicula).
tiene_propiedad(mulan, dirigido_por, tony_bancroft).
tiene_propiedad(mulan, pertenece_a, animacion).
tiene_propiedad(toy_story, dirigido_por, john_lasseter).
tiene_propiedad(toy_story, pertenece_a, animacion).
tiene_propiedad(aladdin, dirigido_por, ron_clements).
tiene_propiedad(aladdin, pertenece_a, animacion).
tiene_propiedad(walt_disney, produjo, el_rey_leon).
tiene_propiedad(walt_disney, produjo, frozen).
tiene_propiedad(walt_disney, produjo, mulan).
tiene_propiedad(walt_disney, produjo, toy_story).
tiene_propiedad(walt_disney, produjo, aladdin).

%%%%%% REGLAS
% Regla para saber si un objeto es una instancia de una clase en concreto
es(Clase, Obj) :- instancia_de(Obj, Clase).
es(Clase, Obj) :- instancia_de(Obj, Clasep),
                  subc(Clasep, Clase).

% Regla para saber si una clase es subclase de otra
subc(C1, C2) :- subclase_de(C1, C2).
subc(C1, C2) :- subclase_de(C1, C3),
                subc(C3, C2).


pertenece_a_genero(Objeto, Genero) :-
    tiene_propiedad(Objeto, pertenece_a, Genero).

% Regla para saber las propiedades de un objeto
propiedad(Obj, Propiedad, Valor) :- tiene_propiedad(Obj, Propiedad, Valor).

% Regla para obtener todas las propiedades de un objeto
todas_las_propiedades(Obj, PropList) :-
    findall(Propiedad-Valor, propiedad(Obj, Propiedad, Valor), PropList).

% Exportar a DOT
export_to_dot(FileName) :-
    open(FileName, write, Stream),
    write(Stream, 'digraph G {\n'),

    % Exportar instancia_de
    forall(instancia_de(Obj, Clase),
           format(Stream, '  "~w" -> "~w" [label="instancia_de"];\n', [Obj, Clase])),

    % Exportar subclase_de
    forall(subclase_de(Subclase, Clase),
           format(Stream, '  "~w" -> "~w" [label="subclase_de"];\n', [Subclase, Clase])),

    % Exportar tiene_propiedad
    forall(tiene_propiedad(Clase1, Propiedad, Clase2),
           format(Stream, '  "~w" -> "~w" [label="~w"];\n', [Clase1, Clase2, Propiedad])),

    write(Stream, '}\n'),
    close(Stream).

% Llamar a export_to_dot/1 con el nombre del archivo de salida
:- export_to_dot('red_cine.dot').
