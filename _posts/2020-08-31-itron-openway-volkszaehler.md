---
layout: post
title: Itron Openway mit Volkszähler
lang: de
tags:
  - itron
  - openway
  - volkszaehler
---

Vor einer Weile hat mich mein Vater gebeten ihm zu helfen herauszufinden wie
viel Strom seiner neuen Photovoltaikanlage er an seinen Energieanbieter
verschenkt, wenn er sie ins Netz einspeist.

Das hat mich in die Welt der Home Automation eingeführt und ich will meine 
Ergebnisse hier ein wenig dokumentieren.

### Hardware

Mein Vater hat von der EnBW einen Zähler bekommen, der auf der Vorderseite
als "Itron Openway 3Hz" bezeichnet wird. Leider konnte ich online recht wenig
über dieses Modell finden und vermute das ist irgendeine Sonderedition.

### Software

Manuel Wortmann hat einen [sehr guten Post](https://www.manuel-wortmann.de/875/stromzaehler-as1440-stadtwerke-osnabrueck-auslesen/) über sein Setup geschrieben und
ich bin dieser Anleitung gefolgt.

Hier die Kurzversion:

- [Weidmann Optokopf](https://shop.weidmann-elektronik.de/index.php?page=product&info=24) kaufen
- Raspberry Pi kaufen
- Volkszähler-Image auf RasPi installieren
- D0-Schnittstelle (optische Datenausgabe) am Zähler aktivieren
- `vzlogger` konfigurieren

### Datenausgabe über optische Schnittstelle

Um Daten aus dem Itron auszulesen muss die optische Schnittstelle mittels Taschenlampe
und PIN-Eingabe aktiviert werden. Ziel ist es das Gerät in den "Info On" Modus, was
dann auch im Display steht, zu setzen. Das ist eine sehr fummelige Angelegenheit und ist im
Handbuch des Herstellers und in [der des Weidmann Optokopfes](https://shop.weidmann-elektronik.de/media/files_public/ef65a5f91f3dabc8252faaababd91b30/Freischaltung_D0_Schnittstelle.pdf) 
beschrieben.

### Eigenheiten
Um den den Channel anzulegen, habe ich auch nicht den MySQL-Client benutzt, sondern
die Volkszähler-UI. Hierbei ist es wichtig als Typen "El. Energie (Leistungswerte))" auszuwählen.

![Volkszähler Setup](/blog/assets/volkszaehler-leistungsstaende.png)

Die Konfiguration des `vzlogger` für den Itron Openway ist ein wenig anders als beim von Manuel beschriebenen Modell.

- Die Datenausgabe des Stromzählers muss nicht initialisiert werden. Wenn das Gerät auf "Info On"-Modus ist,
  werden die Lichtumpulse alle Sekunde ausgegeben.
- Die Daten sind im sml-Protokoll kodiert.

Das Gerät liefert zwei Werte pro Datenpaket:

1. den klassischen Zählerstand, also eine immerzu steigende Zahl
1. den aktuellen Verbrauch

Mein Vater war an letzerem interessiert und um diese Daten via `vzlogger`
an die Volkszähler-Middleware zu schicken, habe ich folgende `vzlogger.conf`-Datei benutzt:

```json
{
  "retry": 0,
  "daemon": true,
  "verbosity": 0,
  "log": "/var/log/vzlogger.log",
  "local": {
    "enabled": false,
    "port": 8080,
    "index": true,
    "timeout": 0,
    "buffer": 0
  },
  "meters": [
    {
      "enabled": true,
      "device": "/dev/ttyUSB0",
      "protocol": "sml",
      "aggtime": -1,
      "aggfixedinterval": false,
      "baudrate": 9600,
      "parity": "8n1",
      "duplicates": 3600,
      "channels": [
        {
          "uuid": "${von der UI generierte UUID}",
          "middleware": "http://localhost/middleware.php",
          "identifier": "1-0:16.7.0",
          "aggmode": "none"
        }
      ]
    }
  ]
}
```

In dieser Konfiguration wird der Zählerstand nicht weiterverabeitet. Solltest Du an diesem
interessiert sein, dann erhöhe die `verbosity` auf 15 und schau' Dir die Werte und
deren ID im Log an. Dafür könntest Du einen zweiten Channel anlegen und auch diese Werte
aufzeichnen.

### Foto des fertigen Setups

![Itron Openway](/blog/assets/itron-openway.jpg)
