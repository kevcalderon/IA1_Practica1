# Manual Tecnico

### Introduccion

_Este manual describe la estructura y el funcionamiento del sistema de base de conocimientos en Prolog, el cual gestiona información sobre películas, actores, directores, productores, géneros y premios._

### Estructura de Codigo

**Hechos**
_Los hechos se utilizan para representar instancias y relaciones directas entre objetos y clases, así como las propiedades de los objetos._

1. **instancia_de(Objeto, Clase):** Define que un objeto es una instancia de una clase.
2. **subclase_de(Subclase, Clase)** Define la jerarquía de clases.
3. **tiene_propiedad(Objeto, propiedad, Valor):** Asigna propiedades a los objetos.

Ejemplo

```
instancia_de(el_padrino, pelicula).
tiene_propiedad(el_padrino, dirigido_por, francis_ford_coppola).
```

**Reglas**
_Las reglas permiten inferir nuevas informaciones basadas en los hechos._

1. **es(Clase, Obj):** Determina si un objeto es una instancia de una clase.
2. **subc(C1, C2):** Determina si una clase es una subclase de otra.
3. **propiedad(Obj, Prop):** Obtiene las propiedades de un objeto.

Ejemplo

```
es(Clase, Obj) :- instancia_de(Obj, Clase).
es(Clase, Obj) :- instancia_de(Obj, Clasep), subc(Clasep, Clase).

subc(C1, C2) :- subclase_de(C1, C2).
subc(C1, C2) :- subclase_de(C1, C3), subc(C3, C2).

propiedad(Obj, Prop) :- es(Clase, Obj), tiene_propiedad(Clase, Propiedad, Clase2), Prop =.. [Propiedad, Clase2].
```

### Descripccion de Reglas y Hechos

1. **Regla es:**

   Propósito: Determinar si un objeto es una instancia de una clase o una de sus subclases.
   Uso: es(Clase, Obj)

2. **Regla subc:**

   Propósito: Determinar si una clase es una subclase de otra, directa o indirectamente.
   Uso: subc(C1, C2)

3. **Regla propiedad:**

   Propósito: Obtener propiedades de un objeto basado en su clase.
   Uso: todas_las_propiedades(Obj, Prop)

### Ejemplos de Consultas

1. Consultar propiedades de una película:

```
?- todas_las_propiedades(el_padrino, Propiedades).
```

2. Consultar propiedades de un actor:

```
?- todas_las_propiedades(leonardo_dicaprio, Propiedades).
```

3. Consultar propiedades de un director:

```
?- todas_las_propiedades(christopher_nolan, Propiedades).
```
