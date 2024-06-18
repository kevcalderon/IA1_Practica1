# Manual de Usuario

### Introduccion

_Este manual explica cómo interactuar con el sistema de base de conocimientos en Prolog para obtener información sobre películas, actores, directores, géneros y premios._

### Instalación y Configuración

1. Requisitos:

   SWI-Prolog (u otro intérprete Prolog compatible)

2. Instalación de SWI-Prolog:

   Descargar e instalar desde SWI-Prolog.

3. Carga del Código:

   Guardar el código en un archivo con extensión .pl, por ejemplo `base_conocimientos.pl`.

### Cómo Realizar Consultas

1. Consultar si un objeto es una instancia de una clase:

```
?- es(pelicula, el_padrino).
```

2. Consultar si una clase es subclase de otra:

```
?- subc(pelicula, produccion_artistica).
```

3. Consultar las propiedades de un objeto:

```
?- propiedad(el_padrino, Prop).
```

### Ejemplos de Uso

1. Consultar propiedades de "el_padrino":

```
?- propiedad(el_padrino, Prop).
```

Salida esperada:

```

Prop = dirigido_por(francis_ford_coppola) ;
Prop = pertenece_a(drama) ;
Prop = gano(oscar_mejor_pelicula).
```
