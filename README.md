# PostsJSONPlaceholder-iOS

## Installation
Run git clone to download proyect

```ruby
git clone https://github.com/luisMan97/PostsJSONPlaceholder-iOS.git
```

#### Third Party Libraries
The project does not use third party libraries. Don't cocoapods, don't cartage, don't worry :)

#### Funcionalidades
- La pantalla principal cuenta con dos principales secciones; todos los posts de la API publica de JSONPlaceholder (All) y los favoritos persisitos localmente (Favorites).
- La pantalla principal cuenta con una barra de búsqueda.
- La pantalla principal, sección de "All" tiene un botón para volver a llamar los posts desde el API.
- Las filas de los posts de la pantalla principal tienen un indicador (estrella) cuando está guardado como favorito.
- Cuando se selecciona un Post se va al detalle del Post.
- La pantalla principal, sección de "Favorites" tiene un botón para editar los posts favoritos, más especificamente poderlos eliminar.
- Cada post de los favoritos tiene el gesto nativo de deslizar y eliminar.
- Cuando hay posts favoritos, se visualiza un botón de Eliminar todos los favoritos.
- En la pantalla del detalle del Post se visualiza el titulo y la descripción del post, además de los datos del usuario y los comentarios.
- En la pantalla del detalle del Post se tiene un botón para guardar en favoritos el Post.

- Se muestra mensaje de error cuando el servicio falla o no hay conexión a internet.
- Hay una modal de loading que se muestra cada vez que se hace la petición al servicio web.

#### Funcionalidades técnicas:
- La aplicación está desarrollada en Swift 5, con SwiftUI, Combine y Async/Await.
- La aplicación tiene cómo arquitectura un tipo de MVVM extendido (CLEAN Architecture) en la sección del listado de posts y VIP (Clean Swift) en la sección del detalle del post.
- La aplicación usa programación reactiva con Combine.
- La aplicación implementa diferentes patrones de diseño (Repository, Factory entre otros).
- La aplicación no usa librerías de terceros.
- La aplicación usa una capa genérica y extensible con URLSession para hacer los llamados a los servicios.  
- La aplicación usa Codable para el mapeo de JSON a objetos. 
- La aplicación contiene un .gitignore para no subir archivos innecesarios.

#### Arquitectura
Se implementó CLEAN como arquitectura, con las siguientes capas:
1) View: Contiene las View de SwiftUI
2) Presentation: Contiene los ViewModels o Presenters
3) Interactor/UseCases: Contiene los casos de uso (acciones de la aplicación y lógica de negocios)
4) Entity/Domain: Contiene las entidades
5) Data: Contiene el patrón repository para obtener los datos ya sea de una API o una base de datos local
6) Framework: Contiene la implementación a más detalle de la obtención de datos usando ya la respectiva librería o framework (URLSession, CoreData y etc)
