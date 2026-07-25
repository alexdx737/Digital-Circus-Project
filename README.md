# Digital-Circus-Project
> Este es un fanmade de amazing Digital Circus echo con mucho cariño

### Dependencias

> [!TIP]
> Les recomiendo para que les funcione el projecto tener el sdk de flutter y el lenguaje de dart aparte para que se los resconosca

- Flutter 
- Flutter widget snitpet
- Sdk de flutter
- Dart
- Dart-import

```bash
    git clone https://github.com/alexdx737/Digital-Circus-Project.git

    cd digitalcircus

    flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080 
```

Con eso deberia poder abrise la pagina web de flutter.

para modificar y agregar cosas es dentro de la carpeta `lib/main.dart`

flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080

# Arquitectura
La arquitectura del proyecto es la siguiente
```bash 
DIGITAL-CIRCUS-PROJECT/
├── digitalcircus/
│	├── Android/
│	│	├── dependencias/
│	│	└──etc../
│	├── Ios/
│	│	├── dependencias/
│	│	└──etc../
│	├──	lib/ 
│	│	└── main.dart
│	├── Linux/
│	│	├── dependencias/
│	│	└──etc../
│	├── Mac/
│	│	├── dependencias/
│	│	└──etc../
│	├── Test/
│	│	├── dependencias/
│	│	└──etc../
│	├── Web/
│	│	├── dependencias/
│	│	└──etc../
│	├── Windows/
│	│	├── dependencias/
│	│	└──etc../
│	│
│	├── .gitignore
│	├── .metadata
│	├── analysis_options.yaml
│	├── pubspect.yaml
│	└── README.md 
└── README.md
```

