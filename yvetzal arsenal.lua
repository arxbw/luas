-- Yvetzal: Arsenal

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local plrs = game:GetService("Players")
local runSrv = game:GetService("RunService")
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local light = game:GetService("Lighting")
local tweenSrv = game:GetService("TweenService")
local plr = plrs.LocalPlayer

local filePath = "Yvetzal_Arsenal.lua"

if game.PlaceId ~= 286090429 and game.PlaceId ~= 106680097749942 and game.PlaceId ~= 109164313998745 then
    return
end

-- Language
local langList = { "English", "Magyar", "Deutsch", "Français", "Español", "Italiano", "Română" }
local langCode =
    { English = "en", Magyar = "hu", Deutsch = "de", Francais = "fr", Espanol = "es", Italiano = "it", Romana = "ro" }
langCode["Français"], langCode["Español"], langCode["Română"] = "fr", "es", "ro"
local function loadLang()
    local l = "English"
    if getgenv and getgenv().Infernum_Lang and langCode[getgenv().Infernum_Lang] then
        l = getgenv().Infernum_Lang
    end
    pcall(function()
        if readfile then
            local f = readfile("InfernumConfigs/lang.txt")
            if f and #f > 0 and langCode[f] then
                l = f
            end
        end
    end)
    return l
end
local lang = loadLang()
if getgenv then
    getgenv().Infernum_Lang = lang
end

local tr = {
    -- tabs
    ["Home"] = { hu = "Kezdőlap", de = "Start", fr = "Accueil", es = "Inicio", it = "Home", ro = "Acasă" },
    ["Movement"] = {
        hu = "Mozgás",
        de = "Bewegung",
        fr = "Mouvement",
        es = "Movimiento",
        it = "Movimento",
        ro = "Mișcare",
    },
    ["Visuals"] = { hu = "Vizuális", de = "Visuell", fr = "Visuels", es = "Visuales", it = "Visuali", ro = "Vizuale" },
    ["Weapons"] = { hu = "Fegyverek", de = "Waffen", fr = "Armes", es = "Armas", it = "Armi", ro = "Arme" },
    ["Autoplay"] = { hu = "Automata" },
    ["Player"] = { hu = "Játékos", de = "Spieler", fr = "Joueur", es = "Jugador", it = "Giocatore", ro = "Jucător" },
    ["Combat"] = { hu = "Harc", de = "Kampf", fr = "Combat", es = "Combate", it = "Combattimento", ro = "Luptă" },
    ["Teleport"] = {
        hu = "Teleport",
        fr = "Téléportation",
        es = "Teletransporte",
        it = "Teletrasporto",
        ro = "Teleportare",
    },
    ["Farm"] = { de = "Farmen" },
    ["Shaders"] = { hu = "Shaderek" },
    ["Misc"] = { hu = "Egyéb", de = "Sonstiges", fr = "Divers", es = "Varios", it = "Varie", ro = "Diverse" },
    ["Credits"] = { hu = "Készítők", fr = "Crédits", es = "Créditos", it = "Crediti", ro = "Credite" },

    -- sections
    ["WELCOME"] = {
        hu = "ÜDVÖZLÜNK",
        de = "WILLKOMMEN",
        fr = "BIENVENUE",
        es = "BIENVENIDO",
        it = "BENVENUTO",
        ro = "BUN VENIT",
    },
    ["Settings"] = {
        hu = "Beállítások",
        de = "Einstellungen",
        fr = "Paramètres",
        es = "Ajustes",
        it = "Impostazioni",
        ro = "Setări",
    },
    ["MOVEMENT"] = {
        hu = "MOZGÁS",
        de = "BEWEGUNG",
        fr = "MOUVEMENT",
        es = "MOVIMIENTO",
        it = "MOVIMENTO",
        ro = "MISCARE",
    },
    ["SOUNDS"] = { hu = "HANGOK", de = "TÖNE", fr = "SONS", es = "SONIDOS", it = "SUONI", ro = "SUNETE" },
    ["PLAYERS"] = {
        hu = "JÁTÉKOSOK",
        de = "SPIELER",
        fr = "JOUEURS",
        es = "JUGADORES",
        it = "GIOCATORI",
        ro = "JUCĂTORI",
    },
    ["ITEMS"] = { hu = "TÁRGYAK", de = "GEGENSTÄNDE", fr = "OBJETS", es = "OBJETOS", it = "OGGETTI", ro = "OBIECTE" },
    ["QUICK"] = { hu = "GYORS", de = "SCHNELL", fr = "RAPIDE", es = "RÁPIDO", it = "VELOCE", ro = "RAPID" },
    ["TO PLAYER"] = {
        hu = "JÁTÉKOSHOZ",
        de = "ZUM SPIELER",
        fr = "VERS JOUEUR",
        es = "A JUGADOR",
        it = "AL GIOCATORE",
        ro = "LA JUCĂTOR",
    },
    ["COLOR"] = { hu = "SZÍNEK", de = "FARBEN", fr = "COULEURS", es = "COLOR", it = "COLORI", ro = "CULORI" },
    ["EFFECTS"] = { hu = "EFFEKTEK", de = "EFFEKTE", fr = "EFFETS", es = "EFECTOS", it = "EFFETTI", ro = "EFECTE" },
    ["APPEARANCE"] = {
        hu = "MEGJELENÉS",
        de = "AUSSEHEN",
        fr = "APPARENCE",
        es = "APARIENCIA",
        it = "ASPECT",
        ro = "ASPECT",
    },
    ["LANGUAGE"] = { hu = "NYELV", de = "SPRACHE", fr = "LANGUE", es = "IDIOMA", it = "LINGUA", ro = "LIMBĂ" },
    ["CAMERA"] = { hu = "KAMERA", fr = "CAMÉRA", es = "CÁMARA", ro = "CAMERĂ" },
    ["CHARACTER & SERVER"] = {
        hu = "KARAKTER & SZERVER",
        de = "CHARAKTER & SERVER",
        fr = "PERSONNAGE & SERVEUR",
        es = "PERSONAJE Y SERVIDOR",
        it = "PERSONAGGIO & SERVER",
        ro = "PERSONAJ & SERVER",
    },
    ["TOGGLES"] = {
        hu = "KAPCSOLÓK",
        de = "SCHALTER",
        fr = "INTERRUPTEURS",
        es = "INTERRUPTORES",
        it = "INTERRUTTORI",
        ro = "COMUTATOARE",
    },
    ["WORLD"] = { hu = "VILÁG", de = "WELT", fr = "MONDE", es = "MUNDO", it = "MONDO", ro = "LUME" },
    ["AMMO & FIRE"] = {
        hu = "LŐSZER & TŰZ",
        de = "MUNITION & FEUER",
        fr = "MUNITION & TIR",
        es = "MUNICIÓN Y DISPARO",
        it = "MUNIZIONE & FUOCO",
        ro = "MUNIȚIE & FOC",
    },
    ["ACCURACY"] = {
        hu = "PONTOSSÁG",
        de = "PRÄZISION",
        fr = "PRÉCISION",
        es = "PRECISIÓN",
        it = "PRECISIONE",
        ro = "PRECIZIE",
    },
    ["PLAYER ESP"] = {
        hu = "JÁTÉKOS ESP",
        de = "SPIELER-ESP",
        fr = "ESP JOUEURS",
        es = "ESP JUGADORES",
        it = "ESP GIOCATORI",
        ro = "ESP JUCĂTORI",
    },
    ["CHARMS"] = { hu = "CHARMOK", fr = "CHARMES", ro = "FARMECE" },

    -- misc / menu
    ["Menu Toggle Key"] = {
        hu = "Menü gomb",
        de = "Menü-Taste",
        fr = "Touche du menu",
        es = "Tecla del menú",
        it = "Tasto menu",
        ro = "Tasta meniu",
    },
    ["Theme"] = { hu = "Téma", de = "Design", fr = "Thème", es = "Tema", it = "Tema", ro = "Temă" },
    ["Language"] = { hu = "Nyelv", de = "Sprache", fr = "Langue", es = "Idioma", it = "Lingua", ro = "Limbă" },
    ["Re-execute"] = {
        hu = "Újratöltés",
        de = "Neu laden",
        fr = "Réexécuter",
        es = "Reejecutar",
        it = "Riesegui",
        ro = "Reexecută",
    },
    ["Reset Character"] = {
        hu = "Karakter újraindítása",
        de = "Charakter zurücksetzen",
        fr = "Réinitialiser le personnage",
        es = "Reiniciar personaje",
        it = "Reimposta personaggio",
        ro = "Resetează personajul",
    },
    ["Rejoin Server"] = {
        hu = "Újracsatlakozás",
        de = "Server neu beitreten",
        fr = "Rejoindre le serveur",
        es = "Reincorporarse al servidor",
        it = "Rientra nel server",
        ro = "Reintră în server",
    },
    ["Server Hop"] = {
        hu = "Szerver váltás",
        de = "Serverwechsel",
        fr = "Changer de serveur",
        es = "Cambiar de servidor",
        it = "Cambia server",
        ro = "Schimbă serverul",
    },
    ["Low Server"] = {
        hu = "Üres szerver",
        de = "Leerer Server",
        fr = "Serveur vide",
        es = "Servidor vacío",
        it = "Server vuoto",
        ro = "Server gol",
    },
    ["High Server (not full)"] = {
        hu = "Népes szerver (nem teli)",
        de = "Voller Server (nicht voll)",
        fr = "Serveur chargé (non plein)",
        es = "Servidor concurrido (no lleno)",
        it = "Server affollato (non pieno)",
        ro = "Server aglomerat (nu plin)",
    },
    ["Copy JobId"] = {
        hu = "JobId másolása",
        de = "JobId kopieren",
        fr = "Copier le JobId",
        es = "Copiar JobId",
        it = "Copia JobId",
        ro = "Copiază JobId",
    },
    ["Copy HWID"] = {
        hu = "HWID másolása",
        de = "HWID kopieren",
        fr = "Copier le HWID",
        es = "Copiar HWID",
        it = "Copia HWID",
        ro = "Copiază HWID",
    },
    ["Copy GameId"] = {
        hu = "GameId másolása",
        de = "GameId kopieren",
        fr = "Copier le GameId",
        es = "Copiar GameId",
        it = "Copia GameId",
        ro = "Copiază GameId",
    },
    ["Copy User Id"] = {
        hu = "UserId másolása",
        de = "UserId kopieren",
        fr = "Copier l'UserId",
        es = "Copiar UserId",
        it = "Copia UserId",
        ro = "Copiază UserId",
    },
    ["Copied to clipboard."] = {
        hu = "Vágólapra másolva.",
        de = "In die Zwischenablage kopiert.",
        fr = "Copié dans le presse-papiers.",
        es = "Copiado al portapapeles.",
        it = "Copiato negli appunti.",
        ro = "Copiat în clipboard.",
    },
    ["No clipboard support."] = {
        hu = "Nincs vágólap támogatás.",
        de = "Keine Zwischenablage.",
        fr = "Pas de presse-papiers.",
        es = "Sin portapapeles.",
        it = "Nessun supporto appunti.",
        ro = "Fără clipboard.",
    },
    ["No server found."] = {
        hu = "Nem található szerver.",
        de = "Kein Server gefunden.",
        fr = "Aucun serveur trouvé.",
        es = "Ningún servidor encontrado.",
        it = "Nessun server trovato.",
        ro = "Niciun server găsit.",
    },
    ["HWID not supported."] = {
        hu = "HWID nem támogatott.",
        de = "HWID nicht unterstützt.",
        fr = "HWID non supporté.",
        es = "HWID no compatible.",
        it = "HWID non supportato.",
        ro = "HWID nesuportat.",
    },
    ["Day Time"] = {
        hu = "Nappali idő",
        de = "Tageszeit",
        fr = "Heure du jour",
        es = "Hora del día",
        it = "Ora del giorno",
        ro = "Ora zilei",
    },
    ["Unload Script"] = {
        hu = "Szkript eltávolítása",
        de = "Skript entladen",
        fr = "Décharger le script",
        es = "Descargar script",
        it = "Scarica script",
        ro = "Descarcă scriptul",
    },
    ["camera fov, 70 = default"] = {
        hu = "kamera látómező, 70 = alapértelmezett",
        de = "Kamera-FOV, 70 = Standard",
        fr = "fov caméra, 70 = défaut",
        es = "fov de cámara, 70 = predeterminado",
        it = "fov camera, 70 = predefinito",
        ro = "fov cameră, 70 = implicit",
    },
    ["Anti-Lag (Remove Textures)"] = {
        hu = "Anti-lag (textúrák törlése)",
        de = "Anti-Lag (Texturen entfernen)",
        fr = "Anti-lag (supprimer les textures)",
        es = "Anti-lag (quitar texturas)",
        it = "Anti-lag (rimuovi texture)",
        ro = "Anti-lag (elimină texturile)",
    },
    ["Multi-game script hub"] = {
        hu = "Szkript hub több játékhoz",
        de = "Script-Hub für mehrere Spiele",
        fr = "Hub de scripts multi-jeux",
        es = "Hub de scripts para varios juegos",
        it = "Hub di script multi-gioco",
        ro = "Hub de script pentru mai multe jocuri",
    },
    ["Script hub for Arsenal, RoBeats and Murder Mystery 2."] = {
        hu = "Szkript hub az Arsenal, RoBeats és Murder Mystery 2 játékokhoz.",
        de = "Script-Hub für Arsenal, RoBeats und Murder Mystery 2.",
        fr = "Hub de scripts pour Arsenal, RoBeats et Murder Mystery 2.",
        es = "Hub de scripts para Arsenal, RoBeats y Murder Mystery 2.",
        it = "Hub di script per Arsenal, RoBeats e Murder Mystery 2.",
        ro = "Hub de script pentru Arsenal, RoBeats și Murder Mystery 2.",
    },

    -- shaders
    ["Game Brightness"] = {
        hu = "Játék fényerő",
        de = "Spielhelligkeit",
        fr = "Luminosité du jeu",
        es = "Brillo del juego",
        it = "Luminosità del gioco",
        ro = "Luminozitatea jocului",
    },
    ["Luminance"] = {
        hu = "Fényerő",
        de = "Luminanz",
        fr = "Luminance",
        es = "Luminancia",
        it = "Luminanza",
        ro = "Luminanță",
    },
    ["Contrast"] = {
        hu = "Kontraszt",
        de = "Kontrast",
        fr = "Contraste",
        es = "Contraste",
        it = "Contrasto",
        ro = "Contrast",
    },
    ["Saturation"] = {
        hu = "Telítettség",
        de = "Sättigung",
        fr = "Saturation",
        es = "Saturación",
        it = "Saturazione",
        ro = "Saturație",
    },
    ["Tint R"] = {
        hu = "Árnyalat R",
        de = "Tönung R",
        fr = "Teinte R",
        es = "Tinte R",
        it = "Tinta R",
        ro = "Tenta R",
    },
    ["Tint G"] = {
        hu = "Árnyalat G",
        de = "Tönung G",
        fr = "Teinte G",
        es = "Tinte G",
        it = "Tinta G",
        ro = "Tenta G",
    },
    ["Tint B"] = {
        hu = "Árnyalat B",
        de = "Tönung B",
        fr = "Teinte B",
        es = "Tinte B",
        it = "Tinta B",
        ro = "Tenta B",
    },
    ["Bloom Intensity"] = {
        hu = "Bloom erősség",
        de = "Bloom-Intensität",
        fr = "Intensité du bloom",
        es = "Intensidad del bloom",
        it = "Intensità del bloom",
        ro = "Intensitate bloom",
    },
    ["Bloom Size"] = {
        hu = "Bloom méret",
        de = "Bloom-Größe",
        fr = "Taille du bloom",
        es = "Tamaño del bloom",
        it = "Dimensione del bloom",
        ro = "Dimensiune bloom",
    },
    ["Bloom Threshold"] = {
        hu = "Bloom küszöb",
        de = "Bloom-Schwelle",
        fr = "Seuil du bloom",
        es = "Umbral del bloom",
        it = "Soglia del bloom",
        ro = "Prag bloom",
    },
    ["No Fog"] = {
        hu = "Nincs köd",
        de = "Kein Nebel",
        fr = "Sans brouillard",
        es = "Sin niebla",
        it = "Senza nebbia",
        ro = "Fără ceață",
    },
    ["Sun Rays"] = {
        hu = "Napsugarak",
        de = "Sonnenstrahlen",
        fr = "Rayons de soleil",
        es = "Rayos de sol",
        it = "Raggi di sole",
        ro = "Raze de soare",
    },
    ["Depth of Field"] = {
        hu = "Mélységélesség",
        de = "Tiefenschärfe",
        fr = "Profondeur de champ",
        es = "Profundidad de campo",
        it = "Profondità di campo",
        ro = "Profunzime de câmp",
    },
    ["Global Shadows"] = {
        hu = "Globális árnyékok",
        de = "Globale Schatten",
        fr = "Ombres globales",
        es = "Sombras globales",
        it = "Ombre globali",
        ro = "Umbre globale",
    },
    ["Reset Shaders"] = {
        hu = "Shaderek visszaállítása",
        de = "Shader zurücksetzen",
        fr = "Réinitialiser les shaders",
        es = "Reiniciar shaders",
        it = "Reimposta shader",
        ro = "Resetează shader",
    },

    -- neverlose sounds
    ["Hit Sound"] = {
        hu = "Találat hang",
        de = "Treffer-Sound",
        fr = "Son de touche",
        es = "Sonido de golpe",
        it = "Suono di colpo",
        ro = "Sunet de lovire",
    },
    ["Kill Sound"] = {
        hu = "Kill hang",
        de = "Kill-Sound",
        fr = "Son d'élimination",
        es = "Sonido de muerte",
        it = "Suono di kill",
        ro = "Sunet de kill",
    },

    -- robeats
    ["Enable Autoplay"] = {
        hu = "Autoplay bekapcsolása",
        de = "Autoplay aktivieren",
        fr = "Activer l'autoplay",
        es = "Activar autoplay",
        it = "Attiva autoplay",
        ro = "Activează autoplay",
    },
    ["Accuracy (0 = Miss, 100 = Perfect)"] = {
        hu = "Pontosság (0 = hiba, 100 = tökéletes)",
        de = "Genauigkeit (0 = Miss, 100 = Perfekt)",
        fr = "Précision (0 = raté, 100 = parfait)",
        es = "Precisión (0 = fallo, 100 = perfecto)",
        it = "Precisione (0 = miss, 100 = perfetto)",
        ro = "Precizie (0 = rat, 100 = perfect)",
    },
    ["Made by Wyrizon and the Infernum Team."] = {
        hu = "Készítette Wyrizon és az Infernum Csapat.",
        de = "Von Wyrizon und dem Infernum-Team.",
        fr = "Par Wyrizon et l'équipe Yvetzal.",
        es = "Hecho por Wyrizon y el equipo de Infernum.",
        it = "Realizzato da Wyrizon e dal team Infernum.",
        ro = "Creat de Wyrizon și echipa Infernum.",
    },
    ["Autoplay On"] = {
        hu = "Autoplay bekapcsolva",
        de = "Autoplay an",
        fr = "Autoplay activé",
        es = "Autoplay activado",
        it = "Autoplay attivo",
        ro = "Autoplay activat",
    },
    ["Autoplay Off"] = {
        hu = "Autoplay kikapcsolva",
        de = "Autoplay aus",
        fr = "Autoplay désactivé",
        es = "Autoplay desactivado",
        it = "Autoplay disattivo",
        ro = "Autoplay dezactivat",
    },
    ["Hitting notes automatically."] = {
        hu = "A hangjegyek automatikus leütése.",
        de = "Noten werden automatisch getroffen.",
        fr = "Frappe les notes automatiquement.",
        es = "Golpea las notas automáticamente.",
        it = "Colpisce le note automaticamente.",
        ro = "Lovește notele automat.",
    },
    ["Stopped."] = {
        hu = "Leállítva.",
        de = "Gestoppt.",
        fr = "Arrêté.",
        es = "Detenido.",
        it = "Fermato.",
        ro = "Oprit.",
    },
    ["Autoplay unavailable (no track system or debug fns). Try re-executing after the game loads."] = {
        hu = "Az autoplay nem elérhető (nincs track rendszer vagy debug függvény). Próbáld újra a betöltés után.",
        de = "Autoplay nicht verfügbar (kein Track-System oder Debug-Funktionen). Nach dem Laden erneut ausführen.",
        fr = "Autoplay indisponible (pas de système de piste ni fonctions de debug). Réessaie après le chargement du jeu.",
        es = "Autoplay no disponible (sin sistema de pistas ni funciones de debug). Reejecuta tras cargar el juego.",
        it = "Autoplay non disponibile (nessun sistema di tracce né funzioni di debug). Riesegui dopo il caricamento del gioco.",
        ro = "Autoplay indisponibil (fără sistem de track sau funcții de debug). Reexecută după încărcarea jocului.",
    },

    -- mm2
    ["Walkspeed"] = {
        hu = "Mozgássebesség",
        de = "Geschwindigkeit",
        fr = "Vitesse",
        es = "Velocidad",
        it = "Velocità",
        ro = "Viteză",
    },
    ["JumpPower"] = {
        hu = "Ugróerő",
        de = "Sprungkraft",
        fr = "Puissance de saut",
        es = "Potencia de salto",
        it = "Potenza di salto",
        ro = "Putere de sărit",
    },
    ["Infinite Jump"] = {
        hu = "Végtelen ugrás",
        de = "Unendlicher Sprung",
        fr = "Saut infini",
        es = "Salto infinito",
        it = "Salto infinito",
        ro = "Salt infinit",
    },
    ["Anti Fling"] = { hu = "Fling védelem" },
    ["Sound"] = { hu = "Hang", fr = "Son", es = "Sonido", it = "Suono", ro = "Sunet" },
    ["Volume"] = { hu = "Hangerő", de = "Lautstärke", fr = "Volume", es = "Volumen", it = "Volume", ro = "Volum" },
    ["Play Sound"] = {
        hu = "Hang lejátszása",
        de = "Sound abspielen",
        fr = "Jouer le son",
        es = "Reproducir sonido",
        it = "Riproduci suono",
        ro = "Redă sunetul",
    },
    ["Highlight"] = {
        hu = "Kiemelés",
        de = "Hervorhebung",
        fr = "Surbrillance",
        es = "Resaltado",
        it = "Evidenzia",
        ro = "Evidențiere",
    },
    ["Name ESP"] = {
        hu = "Név ESP",
        de = "Namen-ESP",
        fr = "ESP noms",
        es = "ESP de nombres",
        it = "ESP nomi",
        ro = "ESP nume",
    },
    ["Skeleton ESP"] = {
        hu = "Csontváz ESP",
        de = "Skelett-ESP",
        fr = "ESP squelette",
        es = "ESP esqueleto",
        it = "ESP scheletro",
        ro = "ESP schelet",
    },
    ["Gun ESP"] = {
        hu = "Fegyver ESP",
        de = "Waffen-ESP",
        fr = "ESP arme",
        es = "ESP arma",
        it = "ESP arma",
        ro = "ESP armă",
    },
    ["Coin ESP"] = { hu = "Érme ESP", fr = "ESP pièces", es = "ESP monedas", it = "ESP monete", ro = "ESP monede" },
    ["Fling Mode"] = {
        hu = "Fling mód",
        de = "Fling-Modus",
        fr = "Mode fling",
        es = "Modo fling",
        it = "Modalità fling",
        ro = "Mod fling",
    },
    ["Fling Target"] = {
        hu = "Fling cél",
        de = "Fling-Ziel",
        fr = "Cible fling",
        es = "Objetivo fling",
        it = "Bersaglio fling",
        ro = "Țintă fling",
    },
    ["Fling All"] = {
        hu = "Mindet flingel",
        de = "Alle flingen",
        fr = "Flinger tout",
        es = "Flingear a todos",
        it = "Flinga tutti",
        ro = "Fling la toți",
    },
    ["Fling Murderer"] = {
        hu = "Gyilkos flingelése",
        de = "Mörder flingen",
        fr = "Flinger le meurtrier",
        es = "Flingear al asesino",
        it = "Flinga l'assassino",
        ro = "Fling la ucigaș",
    },
    ["Fling Sheriff"] = {
        hu = "Seriff flingelése",
        de = "Sheriff flingen",
        fr = "Flinger le shérif",
        es = "Flingear al sheriff",
        it = "Flinga lo sceriffo",
        ro = "Fling la șerif",
    },
    ["Fling by Name"] = {
        hu = "Fling név alapján",
        de = "Fling nach Name",
        fr = "Fling par nom",
        es = "Flingear por nombre",
        it = "Flinga per nome",
        ro = "Fling după nume",
    },
    ["Player Name"] = {
        hu = "Játékos neve",
        de = "Spielername",
        fr = "Nom du joueur",
        es = "Nombre del jugador",
        it = "Nome del giocatore",
        ro = "Numele jucătorului",
    },
    ["player name (partial works)"] = {
        hu = "játékos neve (részleges is jó)",
        de = "Spielername (auch teilweise)",
        fr = "nom du joueur (partiel ok)",
        es = "nombre del jugador (vale parcial)",
        it = "nome del giocatore (anche parziale)",
        ro = "numele jucătorului (și parțial)",
    },
    ["No matching player."] = {
        hu = "Nincs egyező játékos.",
        de = "Kein passender Spieler.",
        fr = "Aucun joueur correspondant.",
        es = "Ningún jugador coincide.",
        it = "Nessun giocatore corrispondente.",
        ro = "Niciun jucător potrivit.",
    },
    ["Warning"] = { hu = "Figyelem", de = "Warnung", fr = "Attention", es = "Aviso", it = "Avviso", ro = "Atenție" },
    ["Flinging is easily detected - use at your own risk."] = {
        hu = "A flingelés könnyen észrevehető - saját felelősségre.",
        de = "Flingen ist leicht erkennbar - auf eigene Gefahr.",
        fr = "Le fling est facilement détectable - à vos risques et périls.",
        es = "El fling se detecta fácilmente - bajo tu responsabilidad.",
        it = "Il fling è facilmente rilevabile - a tuo rischio.",
        ro = "Flingul se detectează ușor - pe propriul risc.",
    },
    ["Spinbot Speed"] = {
        hu = "Spinbot sebesség",
        de = "Spinbot-Tempo",
        fr = "Vitesse du spinbot",
        es = "Velocidad del spinbot",
        it = "Velocità spinbot",
        ro = "Viteză spinbot",
    },
    ["Target Role"] = {
        hu = "Cél szerep",
        de = "Ziel-Rolle",
        fr = "Rôle cible",
        es = "Rol objetivo",
        it = "Ruolo bersaglio",
        ro = "Rol țintă",
    },
    ["Aim Part"] = {
        hu = "Cél testrész",
        de = "Ziel-Körperteil",
        fr = "Partie visée",
        es = "Parte objetivo",
        it = "Parte mirata",
        ro = "Parte țintă",
    },
    ["Grab Gun"] = {
        hu = "Fegyver felvétele",
        de = "Waffe aufheben",
        fr = "Prendre l'arme",
        es = "Coger el arma",
        it = "Prendi l'arma",
        ro = "Ia arma",
    },
    ["Go to Lobby"] = {
        hu = "Lobbyba",
        de = "Zur Lobby",
        fr = "Aller au lobby",
        es = "Ir al lobby",
        it = "Vai alla lobby",
        ro = "Mergi în lobby",
    },
    ["Go to Map Spawn"] = {
        hu = "Térkép spawnra",
        de = "Zum Map-Spawn",
        fr = "Aller au spawn de la carte",
        es = "Ir al spawn del mapa",
        it = "Vai allo spawn della mappa",
        ro = "Mergi la spawnul hărții",
    },
    ["Teleport to Murderer"] = {
        hu = "Gyilkoshoz teleport",
        de = "Zum Mörder teleportieren",
        fr = "Téléport au meurtrier",
        es = "Teletransporte al asesino",
        it = "Teletrasporto all'assassino",
        ro = "Teleport la ucigaș",
    },
    ["Teleport to Sheriff"] = {
        hu = "Seriffhez teleport",
        de = "Zum Sheriff teleportieren",
        fr = "Téléport au shérif",
        es = "Teletransporte al sheriff",
        it = "Teletrasporto allo sceriffo",
        ro = "Teleport la șerif",
    },
    ["Refresh List"] = {
        hu = "Lista frissítése",
        de = "Liste aktualisieren",
        fr = "Rafraîchir la liste",
        es = "Actualizar lista",
        it = "Aggiorna lista",
        ro = "Actualizează lista",
    },
    ["Teleport to Player"] = {
        hu = "Játékoshoz teleport",
        de = "Zum Spieler teleportieren",
        fr = "Téléport au joueur",
        es = "Teletransporte al jugador",
        it = "Teletrasporto al giocatore",
        ro = "Teleport la jucător",
    },
    ["Farm Speed"] = {
        hu = "Farm sebesség",
        de = "Farm-Tempo",
        fr = "Vitesse de farm",
        es = "Velocidad de farm",
        it = "Velocità farm",
        ro = "Viteză farm",
    },
    ["Coin Farm"] = {
        hu = "Érme farm",
        de = "Münzen-Farm",
        fr = "Farm de pièces",
        es = "Farm de monedas",
        it = "Farm di monete",
        ro = "Farm de monede",
    },

    -- arsenal movement
    ["Fly"] = { hu = "Repülés", de = "Fliegen", fr = "Vol", es = "Volar", it = "Volo", ro = "Zbor" },
    ["WASD to move"] = {
        hu = "WASD a mozgáshoz",
        de = "WASD zum Bewegen",
        fr = "WASD pour se déplacer",
        es = "WASD para moverse",
        it = "WASD per muoversi",
        ro = "WASD pentru mișcare",
    },
    ["Fly Speed"] = {
        hu = "Repülési sebesség",
        de = "Fluggeschwindigkeit",
        fr = "Vitesse de vol",
        es = "Velocidad de vuelo",
        it = "Velocità di volo",
        ro = "Viteză de zbor",
    },
    ["Custom Walkspeed"] = {
        hu = "Egyedi sebesség",
        de = "Eigene Geschwindigkeit",
        fr = "Vitesse personnalisée",
        es = "Velocidad personalizada",
        it = "Velocità personalizzata",
        ro = "Viteză personalizată",
    },
    ["Walk Method"] = {
        hu = "Mozgásmód",
        de = "Laufmethode",
        fr = "Méthode de déplacement",
        es = "Método de movimiento",
        it = "Metodo di spostamento",
        ro = "Metodă de deplasare",
    },
    ["Walkspeed Power"] = {
        hu = "Sebesség erő",
        de = "Tempo-Wert",
        fr = "Valeur de vitesse",
        es = "Valor de velocidad",
        it = "Valore velocità",
        ro = "Valoare viteză",
    },
    ["Custom JumpPower"] = {
        hu = "Egyedi ugróerő",
        de = "Eigene Sprungkraft",
        fr = "Saut personnalisé",
        es = "Salto personalizado",
        it = "Salto personalizzato",
        ro = "Salt personalizat",
    },
    ["Jump Method"] = {
        hu = "Ugrásmód",
        de = "Sprungmethode",
        fr = "Méthode de saut",
        es = "Método de salto",
        it = "Metodo di salto",
        ro = "Metodă de sărit",
    },
    ["JumpPower Value"] = {
        hu = "Ugróerő érték",
        de = "Sprungkraft-Wert",
        fr = "Valeur de saut",
        es = "Valor de salto",
        it = "Valore salto",
        ro = "Valoare săritură",
    },
    ["Reset Collision"] = {
        hu = "Ütközés visszaállítása",
        de = "Kollision zurücksetzen",
        fr = "Réinitialiser les collisions",
        es = "Reiniciar colisión",
        it = "Reimposta collisioni",
        ro = "Resetează coliziunea",
    },
    ["hold space to auto-hop"] = {
        hu = "tartsd nyomva a space-t",
        de = "Leertaste halten",
        fr = "maintiens espace pour sauter",
        es = "mantén espacio para saltar",
        it = "tieni premuto spazio",
        ro = "ține space pentru salt",
    },
    ["Collect Debris"] = {
        hu = "Szemét begyűjtése",
        de = "Trümmer sammeln",
        fr = "Ramasser les débris",
        es = "Recoger escombros",
        it = "Raccogli detriti",
        ro = "Colectează resturile",
    },
    ["Select Object"] = {
        hu = "Tárgy kiválasztása",
        de = "Objekt wählen",
        fr = "Objet à ramasser",
        es = "Objeto a recoger",
        it = "Oggetto da raccogliere",
        ro = "Obiect de colectat",
    },
    ["Anti-Aim (Spin)"] = { hu = "Anti-Aim (pörgetés)" },
    ["Spin Speed"] = {
        hu = "Pörgés sebesség",
        de = "Spin-Tempo",
        fr = "Vitesse de rotation",
        es = "Velocidad de giro",
        it = "Velocità di rotazione",
        ro = "Viteză de rotație",
    },
    ["Third Person"] = {
        hu = "Harmadik személy",
        fr = "Troisième personne",
        es = "Tercera persona",
        it = "Terza persona",
        ro = "Persoana a treia",
    },
    ["TP Distance"] = {
        hu = "TP távolság",
        de = "TP-Abstand",
        fr = "Distance TP",
        es = "Distancia TP",
        it = "Distanza TP",
        ro = "Distanță TP",
    },
    ["TP Height"] = {
        hu = "TP magasság",
        de = "TP-Höhe",
        fr = "Hauteur TP",
        es = "Altura TP",
        it = "Altezza TP",
        ro = "Înălțime TP",
    },
    ["- = front, + = behind"] = {
        hu = "- = előre, + = hátra",
        de = "- = vorne, + = hinten",
        fr = "- = devant, + = derrière",
        es = "- = delante, + = detrás",
        it = "- = davanti, + = dietro",
        ro = "- = în față, + = în spate",
    },

    -- arsenal hitbox / triggerbot
    ["Enable Hitbox"] = {
        hu = "Hitbox bekapcsolása",
        de = "Hitbox aktivieren",
        fr = "Activer la hitbox",
        es = "Activar hitbox",
        it = "Attiva hitbox",
        ro = "Activează hitbox",
    },
    ["Hitbox Target"] = {
        hu = "Hitbox cél",
        de = "Hitbox-Ziel",
        fr = "Cible hitbox",
        es = "Objetivo hitbox",
        it = "Bersaglio hitbox",
        ro = "Țintă hitbox",
    },
    ["Hitbox Size"] = {
        hu = "Hitbox méret",
        de = "Hitbox-Größe",
        fr = "Taille hitbox",
        es = "Tamaño hitbox",
        it = "Dimensione hitbox",
        ro = "Dimensiune hitbox",
    },
    ["Hitbox Transparency"] = {
        hu = "Hitbox átlátszóság",
        de = "Hitbox-Transparenz",
        fr = "Transparence hitbox",
        es = "Transparencia hitbox",
        it = "Trasparenza hitbox",
        ro = "Transparență hitbox",
    },
    ["1 = visible, 10 = invisible"] = {
        hu = "1 = látható, 10 = láthatatlan",
        de = "1 = sichtbar, 10 = unsichtbar",
        fr = "1 = visible, 10 = invisible",
        es = "1 = visible, 10 = invisible",
        it = "1 = visibile, 10 = invisibile",
        ro = "1 = vizibil, 10 = invizibil",
    },
    ["No Collision"] = {
        hu = "Ütközés kikapcsolása",
        de = "Ohne Kollision",
        fr = "Sans collision",
        es = "Sin colisión",
        it = "Senza collisione",
        ro = "Fără coliziune",
    },
    ["Team Check"] = {
        hu = "Csapat szűrés",
        de = "Team-Check",
        fr = "Vérif. d'équipe",
        es = "Comprobación de equipo",
        it = "Controllo squadra",
        ro = "Verificare echipă",
    },
    ["Enable Triggerbot"] = {
        hu = "Triggerbot bekapcsolása",
        de = "Triggerbot aktivieren",
        fr = "Activer le triggerbot",
        es = "Activar triggerbot",
        it = "Attiva triggerbot",
        ro = "Activează triggerbot",
    },
    ["Shot Delay"] = {
        hu = "Lövés késleltetés",
        de = "Schussverzögerung",
        fr = "Délai de tir",
        es = "Retardo de disparo",
        it = "Ritardo di sparo",
        ro = "Întârziere tragere",
    },
    ["0 = hold & spray, raise to tap"] = {
        hu = "0 = tartás, nagyobb: kattintgatás",
        de = "0 = halten, erhöhen für Einzelschüsse",
        fr = "0 = maintien (spray), plus = coups simples",
        es = "0 = mantener, más = disparos sueltos",
        it = "0 = tieni premuto, più = colpi singoli",
        ro = "0 = menține, mai mare = foc singur",
    },
    ["locks onto nearest enemy and fires (ban risk)"] = {
        hu = "rázár a legközelebbi ellenségre és tüzel (ban kockázat)",
        de = "zielt auf den nächsten Gegner und feuert (Bann-Risiko)",
        fr = "verrouille l'ennemi le plus proche et tire (risque de ban)",
        es = "fija al enemigo más cercano y dispara (riesgo de baneo)",
        it = "aggancia il nemico più vicino e spara (rischio ban)",
        ro = "țintește inamicul cel mai apropiat și trage (risc de ban)",
    },

    -- esp shared
    ["Enable ESP"] = {
        hu = "ESP bekapcsolása",
        de = "ESP aktivieren",
        fr = "Activer l'ESP",
        es = "Activar ESP",
        it = "Attiva ESP",
        ro = "Activează ESP",
    },
    ["Distance"] = {
        hu = "Távolság",
        de = "Entfernung",
        fr = "Distance",
        es = "Distancia",
        it = "Distanza",
        ro = "Distanță",
    },
    ["Boxes ESP"] = {
        hu = "Doboz ESP",
        de = "Boxen-ESP",
        fr = "ESP boîtes",
        es = "ESP de cajas",
        it = "ESP box",
        ro = "ESP cutii",
    },
    ["Tracers"] = {
        hu = "Vonalak",
        de = "Tracer",
        fr = "Traceurs",
        es = "Trazadores",
        it = "Tracciatori",
        ro = "Trasori",
    },
    ["Team Color"] = {
        hu = "Csapat szín",
        de = "Team-Farbe",
        fr = "Couleur d'équipe",
        es = "Color de equipo",
        it = "Colore squadra",
        ro = "Culoare echipă",
    },
    ["Streamer Mode"] = {
        hu = "Streamer mód",
        de = "Streamer-Modus",
        fr = "Mode streamer",
        es = "Modo streamer",
        it = "Modalità streamer",
        ro = "Mod streamer",
    },
    ["drawing ESP instead of instances"] = {
        hu = "rajzolt ESP az instancek helyett",
        de = "Drawing-ESP statt Instanzen",
        fr = "ESP dessiné au lieu d'instances",
        es = "ESP dibujado en vez de instancias",
        it = "ESP disegnato invece di istanze",
        ro = "ESP desenat în loc de instanțe",
    },
    ["Enemy Color"] = {
        hu = "Ellenség színe",
        de = "Feindfarbe",
        fr = "Couleur ennemi",
        es = "Color enemigo",
        it = "Colore nemico",
        ro = "Culoare inamic",
    },
    ["Teammate Color"] = {
        hu = "Csapattárs színe",
        de = "Mitspielerfarbe",
        fr = "Couleur allié",
        es = "Color aliado",
        it = "Colore alleato",
        ro = "Culoare coleg",
    },

    -- charms / world
    ["Arm Charms"] = {
        hu = "Kar charmok",
        fr = "Charmes de bras",
        es = "Encantos de brazos",
        it = "Charm braccia",
        ro = "Farmece brațe",
    },
    ["Arm Material"] = {
        hu = "Kar anyag",
        de = "Armmaterial",
        fr = "Matériau des bras",
        es = "Material de brazos",
        it = "Materiale braccia",
        ro = "Material brațe",
    },
    ["Arm Color"] = {
        hu = "Kar szín",
        de = "Armfarbe",
        fr = "Couleur des bras",
        es = "Color de brazos",
        it = "Colore braccia",
        ro = "Culoare brațe",
    },
    ["Gun Charms"] = {
        hu = "Fegyver charmok",
        de = "Waffen-Charms",
        fr = "Charmes d'arme",
        es = "Encantos de arma",
        it = "Charm arma",
        ro = "Farmece armă",
    },
    ["Gun Material"] = {
        hu = "Fegyver anyag",
        de = "Waffenmaterial",
        fr = "Matériau de l'arme",
        es = "Material del arma",
        it = "Materiale arma",
        ro = "Material armă",
    },
    ["Gun Color"] = {
        hu = "Fegyver szín",
        de = "Waffenfarbe",
        fr = "Couleur de l'arme",
        es = "Color del arma",
        it = "Colore arma",
        ro = "Culoare armă",
    },
    ["Rainbow Gun"] = {
        hu = "Szivárvány fegyver",
        de = "Regenbogen-Waffe",
        fr = "Arme arc-en-ciel",
        es = "Arma arcoíris",
        it = "Arma arcobaleno",
        ro = "Armă curcubeu",
    },
    ["Rainbow Gun (Fast)"] = {
        hu = "Szivárvány fegyver (gyors)",
        de = "Regenbogen-Waffe (schnell)",
        fr = "Arme arc-en-ciel (rapide)",
        es = "Arma arcoíris (rápida)",
        it = "Arma arcobaleno (veloce)",
        ro = "Armă curcubeu (rapid)",
    },
    ["Ammo Box ESP"] = {
        hu = "Lőszerdoboz ESP",
        de = "Munitionsbox-ESP",
        fr = "ESP caisse de munitions",
        es = "ESP caja de munición",
        it = "ESP cassa munizioni",
        ro = "ESP cutie muniție",
    },
    ["HP Jug ESP"] = {
        hu = "HP kanna ESP",
        de = "HP-Kanister-ESP",
        fr = "ESP bidon de PV",
        es = "ESP bidón de vida",
        it = "ESP tanica HP",
        ro = "ESP bidon HP",
    },

    -- weapons
    ["Infinite Ammo v1"] = {
        hu = "Végtelen lőszer v1",
        de = "Unendliche Munition v1",
        fr = "Munitions infinies v1",
        es = "Munición infinita v1",
        it = "Munizioni infinite v1",
        ro = "Muniție infinită v1",
    },
    ["Infinite Ammo v2"] = {
        hu = "Végtelen lőszer v2",
        de = "Unendliche Munition v2",
        fr = "Munitions infinies v2",
        es = "Munición infinita v2",
        it = "Munizioni infinite v2",
        ro = "Muniție infinită v2",
    },
    ["infinite ammo curse"] = {
        hu = "végtelen lőszer curse",
        de = "Fluch: unendliche Munition",
        fr = "malédiction : munitions infinies",
        es = "maldición: munición infinita",
        it = "maledizione: munizioni infinite",
        ro = "blestem: muniție infinită",
    },
    ["forces ammo to 99"] = {
        hu = "lőszert 99-re állítja",
        de = "setzt Munition auf 99",
        fr = "force les munitions à 99",
        es = "fuerza la munición a 99",
        it = "forza le munizioni a 99",
        ro = "forțează muniția la 99",
    },
    ["Fast Reload"] = {
        hu = "Gyors újratöltés",
        de = "Schnelles Nachladen",
        fr = "Rechargement rapide",
        es = "Recarga rápida",
        it = "Ricarica rapida",
        ro = "Reîncărcare rapidă",
    },
    ["Fast Fire Rate"] = {
        hu = "Gyors tűzgyorsaság",
        de = "Hohe Feuerrate",
        fr = "Cadence rapide",
        es = "Cadencia rápida",
        it = "Cadenza rapida",
        ro = "Cadență rapidă",
    },
    ["Always Auto"] = {
        hu = "Mindig automata",
        de = "Immer automatisch",
        fr = "Toujours auto",
        es = "Siempre automático",
        it = "Sempre automatica",
        ro = "Mereu automat",
    },
    ["No Spread"] = {
        hu = "Nincs szórás",
        de = "Keine Streuung",
        fr = "Sans dispersion",
        es = "Sin dispersión",
        it = "Senza dispersione",
        ro = "Fără dispersie",
    },
    ["No Recoil"] = {
        hu = "Nincs visszarúgás",
        de = "Kein Rückstoß",
        fr = "Sans recul",
        es = "Sin retroceso",
        it = "Senza rinculo",
        ro = "Fără recul",
    },

    -- universal
    ["Enabled"] = {
        hu = "Bekapcsolva",
        de = "Aktiviert",
        fr = "Activé",
        es = "Activado",
        it = "Attivo",
        ro = "Activat",
    },
    ["Target Part"] = {
        hu = "Cél testrész",
        de = "Ziel-Körperteil",
        fr = "Partie cible",
        es = "Parte objetivo",
        it = "Parte bersaglio",
        ro = "Parte țintă",
    },
    ["Smoothness"] = {
        hu = "Simítás",
        de = "Glättung",
        fr = "Douceur",
        es = "Suavidad",
        it = "Morbidezza",
        ro = "Fluiditate",
    },
    ["Visibility Check"] = {
        hu = "Láthatóság ellenőrzés",
        de = "Sichtbarkeits-Check",
        fr = "Vérif. de visibilité",
        es = "Comprobación de visibilidad",
        it = "Controllo visibilità",
        ro = "Verificare vizibilitate",
    },
    ["Hit Chance"] = {
        hu = "Találati esély",
        de = "Trefferchance",
        fr = "Chance de toucher",
        es = "Probabilidad de acierto",
        it = "Probabilità di colpo",
        ro = "Șansă de lovire",
    },
    ["Show FOV Circle"] = {
        hu = "FOV kör mutatása",
        de = "FOV-Kreis anzeigen",
        fr = "Afficher le cercle FOV",
        es = "Mostrar círculo FOV",
        it = "Mostra cerchio FOV",
        ro = "Afișează cerc FOV",
    },
}
local function L(s)
    local t = tr[s]
    if not t then
        return s
    end
    return t[langCode[lang]] or s
end

local langMsg = {
    English = "Saved. Re-execute the script to apply the new language.",
    Magyar = "Mentve. Újra futtatva lép életbe az új nyelv.",
    Deutsch = "Gespeichert. Skript erneut ausführen, um die Sprache zu übernehmen.",
    Francais = "Enregistré. Réexécutez le script pour appliquer la nouvelle langue.",
    Espanol = "Guardado. Vuelve a ejecutar el script panura aplicar el evo idioma.",
    Italiano = "Salvato. Riesegui lo script per applicare la nuova lingua.",
    Romana = "Salvat. Reexecută scriptul pentru a aplica noua limbă.",
}
local loadedMsg = {
    English = "Loaded (%s) - toggle with %s",
    Magyar = "Betöltve (%s) - menü gomb: %s",
    Deutsch = "Geladen (%s) - Menü-Taste: %s",
    Francais = "Chargé (%s) - touche du menu : %s",
    Espanol = "Cargado (%s) - tecla del menú: %s",
    Italiano = "Caricato (%s) - tasto menu: %s",
    Romana = "Încărcat (%s) - tasta meniu: %s",
}

-- Themes
-- Keep the reference palette; the other presets adjust it in place.
local THEME = {
    WindowColor = ColorSequence.new(Color3.fromRGB(8, 8, 8), Color3.fromRGB(0, 0, 0)),
    ShadowColor = Color3.fromRGB(0, 0, 0),
    SurfaceStroke = Color3.fromRGB(120, 15, 15),
    CornerRoundness = UDim.new(0, 8),
    ElementCornerRadius = UDim.new(0, 6),
    ContentColor = Color3.fromRGB(230, 230, 230),
    TitlingColor = Color3.fromRGB(255, 255, 255),
    ActionColor = Color3.fromRGB(255, 255, 255),
    ElementTextHoverColor = Color3.fromRGB(255, 255, 255),
    TabColor = Color3.fromRGB(255, 255, 255),
    TabBackground = ColorSequence.new(Color3.fromRGB(22, 22, 22), Color3.fromRGB(8, 8, 8)),
    TabStroke = ColorSequence.new(Color3.fromRGB(230, 30, 30), Color3.fromRGB(110, 10, 10)),
    ElementGradient = ColorSequence.new(Color3.fromRGB(18, 18, 18), Color3.fromRGB(10, 10, 10)),
    ElementStroke = Color3.fromRGB(60, 60, 60),
    ElementStrokeHover = Color3.fromRGB(230, 40, 40),
    StatBackground = Color3.fromRGB(30, 6, 6),
    AccentColor = Color3.fromRGB(220, 25, 25),
    AccentStroke = Color3.fromRGB(255, 70, 70),
    SliderBackground = Color3.fromRGB(35, 35, 35),
    SliderProgress = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(210, 210, 210)),
    SliderHandle = Color3.fromRGB(255, 255, 255),
    SliderStroke = Color3.fromRGB(60, 60, 60),
    ToggleTrack = Color3.fromRGB(30, 30, 30),
    ToggleKnobOff = Color3.fromRGB(220, 220, 220),
    DropdownHighlight = Color3.fromRGB(180, 25, 25),
    FieldBackground = Color3.fromRGB(14, 14, 14),
    FieldGlow = Color3.fromRGB(120, 20, 20),
    PlaceholderColor = Color3.fromRGB(150, 150, 150),
    NeutralButton = Color3.fromRGB(26, 26, 26),
    NeutralButtonHover = Color3.fromRGB(45, 45, 45),
    NeutralButtonStroke = Color3.fromRGB(80, 15, 15),
    ErrorColor = Color3.fromRGB(230, 40, 40),
    ErrorStrokeColor = Color3.fromRGB(255, 90, 90),
}

local function darkTheme(factor)
    local result = table.clone(THEME)
    for _, field in ipairs({ "WindowColor", "TabBackground", "ElementGradient" }) do
        local keypoints = {}
        for _, kp in ipairs(THEME[field].Keypoints) do
            keypoints[#keypoints + 1] = ColorSequenceKeypoint.new(kp.Time, kp.Value:Lerp(Color3.new(0, 0, 0), factor))
        end
        result[field] = ColorSequence.new(keypoints)
    end
    for _, field in ipairs({
        "SliderBackground",
        "ToggleTrack",
        "FieldBackground",
        "NeutralButton",
        "NeutralButtonHover",
    }) do
        result[field] = THEME[field]:Lerp(Color3.new(0, 0, 0), factor)
    end
    return result
end
local crimsonTheme = table.clone(THEME)
crimsonTheme.AccentColor = Color3.fromRGB(220, 20, 60)
crimsonTheme.AccentStroke = Color3.fromRGB(255, 70, 100)
local themes = {
    Default = THEME,
    Crimson = crimsonTheme,
    Dark = darkTheme(0.35),
    Darker = darkTheme(0.65),
}
local themeName = "Default"
if getgenv and getgenv().Infernum_Theme and themes[getgenv().Infernum_Theme] then
    themeName = getgenv().Infernum_Theme
end
pcall(function()
    if readfile then
        local f = readfile("InfernumConfigs/theme.txt")
        if f and themes[f] then
            themeName = f
        end
    end
end)
if getgenv then
    getgenv().Infernum_Theme = themeName
end

-- Menu key and cleanup
local menuKeys = {
    Insert = true,
    Delete = true,
    RightShift = true,
    LeftShift = true,
    RightControl = true,
    LeftControl = true,
    F4 = true,
    F6 = true,
    F7 = true,
    F8 = true,
    F9 = true,
    Home = true,
    End = true,
    PageUp = true,
    PageDown = true,
}
local function fixKey(k)
    k = tostring(k or ""):gsub("%s", "")
    if menuKeys[k] then
        return k
    end
    return "Insert"
end
local function loadKey()
    local k = "Insert"
    if getgenv and getgenv().Infernum_MenuKey then
        k = getgenv().Infernum_MenuKey
    end
    pcall(function()
        if readfile then
            local f = readfile("InfernumConfigs/menukey.txt")
            if f and #f > 0 then
                k = f
            end
        end
    end)
    return fixKey(k)
end
local menuKey = loadKey()
local keyEnum = Enum.KeyCode[menuKey] or Enum.KeyCode.Insert
if getgenv then
    getgenv().Infernum_MenuKey = menuKey
end

local conns, cleanups = {}, {}
local function track(c)
    if c then
        conns[#conns + 1] = c
    end
    return c
end
local function onUnload(fn)
    if type(fn) == "function" then
        cleanups[#cleanups + 1] = fn
    end
end
local function unload()
    for _, fn in ipairs(cleanups) do
        pcall(fn)
    end
    for _, c in ipairs(conns) do
        pcall(function()
            if c and c.Disconnect then
                c:Disconnect()
            end
        end)
    end
    cleanups, conns = {}, {}
end

if getgenv and getgenv().Infernum_Unload then
    pcall(getgenv().Infernum_Unload)
end
if getgenv and getgenv().InfernumUI then
    pcall(function()
        getgenv().InfernumUI:Unload()
    end)
    getgenv().InfernumUI = nil
end
if getgenv then
    getgenv().Infernum_Unload = unload
end
onUnload(function()
    pcall(function()
        if mouse1release then
            mouse1release()
        end
    end)
end)

local function getRoot(char)
    if not char then
        return nil
    end
    local r = char:FindFirstChild("HumanoidRootPart")
    if r then
        return r
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.RootPart
end

local function fixCollision(char)
    char = char or plr.Character
    if not char then
        return
    end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            pcall(function()
                p.CanCollide = true
            end)
        end
    end
end

local function fx(class, name)
    local e = light:FindFirstChild(name)
    if e then
        return e
    end
    e = Instance.new(class)
    e.Name = name
    e.Parent = light
    return e
end

local function snd(id, vol)
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = vol or 1
    s.Parent = ws
    s:Play()
    s.Ended:Connect(function()
        s:Destroy()
    end)
end

-- neverlose-style sounds (shared by arsenal + mm2)
local nlSounds = {
    ["NL Hitmarker"] = "rbxassetid://160248522",
    ["NL Headshot"] = "rbxassetid://6383936267",
    ["NL Kill"] = "rbxassetid://3120609515",
    ["NL Click"] = "rbxassetid://7286442500",
    ["NL Bell"] = "rbxassetid://8214292746",
}
local nlKeys = {}
for k in pairs(nlSounds) do
    nlKeys[#nlKeys + 1] = k
end
table.sort(nlKeys)

local function aimedAt(p)
    local char = p.Character
    local head = char and (char:FindFirstChild("Head") or getRoot(char))
    local cam = ws.CurrentCamera
    if not (head and cam) then
        return false
    end
    local dir = head.Position - cam.CFrame.Position
    if dir.Magnitude < 2 then
        return true
    end
    if cam.CFrame.LookVector:Dot(dir.Unit) < 0.985 then
        return false
    end
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = { plr.Character }
    local hit = ws:Raycast(cam.CFrame.Position, dir.Unit * dir.Magnitude, rp)
    return hit ~= nil and (hit.Instance == head or hit.Instance:IsDescendantOf(char))
end
local function ourHit(p)
    local my = getRoot(plr.Character)
    local r = p.Character and getRoot(p.Character)
    if my and r and (my.Position - r.Position).Magnitude < 9 then
        return true
    end
    return aimedAt(p)
end

local function makeNLSounds(tab)
    tab:CreateSection({ name = "NEVERLOSE", icon = "Lucide:volume-2" })
    local cfg = { hit = false, kill = false, hitS = "NL Hitmarker", killS = "NL Kill", vol = 0.6 }
    local watchers = {}
    local function bindHum(p, hum)
        local last = hum.Health
        track(hum.HealthChanged:Connect(function(h)
            if last and last > 0 then
                if h <= 0 then
                    if cfg.kill and ourHit(p) then
                        snd(nlSounds[cfg.killS], cfg.vol)
                    end
                elseif h < last - 0.5 and cfg.hit and ourHit(p) then
                    snd(nlSounds[cfg.hitS], cfg.vol)
                end
            end
            last = h
        end))
    end
    local function watch(p)
        if p == plr or watchers[p] then
            return
        end
        watchers[p] = true
        track(p.CharacterAdded:Connect(function(c)
            task.wait(0.5)
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if hum then
                bindHum(p, hum)
            end
        end))
        if p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                bindHum(p, hum)
            end
        end
    end
    for _, p in ipairs(plrs:GetPlayers()) do
        watch(p)
    end
    track(plrs.PlayerAdded:Connect(watch))

    tab:CreateToggle({
        name = "Hitsound",
        value = false,
        flag = "NL_Hit",
        callback = function(v)
            cfg.hit = v
        end,
    })
    tab:CreateToggle({
        name = "Killsound",
        value = false,
        flag = "NL_Kill",
        callback = function(v)
            cfg.kill = v
        end,
    })
    tab:CreateDropdown({
        name = "Hit Sound",
        options = nlKeys,
        value = "NL Hitmarker",
        flag = "NL_HitSnd",
        callback = function(v)
            cfg.hitS = v
        end,
    })
    tab:CreateDropdown({
        name = "Kill Sound",
        options = nlKeys,
        value = "NL Kill",
        flag = "NL_KillSnd",
        callback = function(v)
            cfg.killS = v
        end,
    })
    tab:CreateSlider({
        name = "Volume",
        range = { 0, 2 },
        value = 0.6,
        increment = 0.05,
        flag = "NL_Vol",
        callback = function(v)
            cfg.vol = v
        end,
    })
end

-- UI
local rayfield
local ok, err = pcall(function()
    rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
end)
if not ok or not rayfield then
    warn("[Yvetzal] Rayfield Gen2 failed to load:", err)
    return
end

local subtitle = "Arsenal"

-- Lucide icons share atlas images. Rayfield needs the sheet ID and crop.
local iconAtlas = {
    ["bot"] = { 16898612819, 869, 98 },
    ["box-select"] = { 16898612819, 820, 147 },
    ["camera"] = { 16898612819, 967, 563 },
    ["crosshair"] = { 16898613044, 453, 869 },
    ["eye"] = { 16898613353, 771, 563 },
    ["flame"] = { 16898613353, 967, 306 },
    ["footprints"] = { 16898613353, 918, 710 },
    ["globe"] = { 16898613509, 771, 563 },
    ["heart"] = { 16898613509, 661, 771 },
    ["keyboard"] = { 16898613509, 453, 820 },
    ["move"] = { 16898613613, 453, 820 },
    ["palette"] = { 16898613613, 453, 918 },
    ["rotate-cw"] = { 16898613699, 869, 453 },
    ["server"] = { 16898613777, 771, 0 },
    ["settings"] = { 16898613777, 771, 257 },
    ["skull"] = { 16898613777, 49, 869 },
    ["sparkles"] = { 16898613777, 918, 49 },
    ["sun"] = { 16898613777, 967, 453 },
    ["sword"] = { 16898613777, 710, 967 },
    ["target"] = { 16898613869, 514, 771 },
    ["toggle-right"] = { 16898613869, 820, 98 },
    ["volume-2"] = { 16898613869, 771, 808 },
    ["wand-2"] = { 16898613869, 918, 453 },
    ["zap"] = { 16898613869, 918, 906 },
}
local function resolveIcon(name)
    if type(name) ~= "string" then
        return name
    end
    local sprite = iconAtlas[name:gsub("^Lucide:", "")]
    return sprite and ("rbxassetid://" .. sprite[1]) or name
end
local function cropIcon(image, name)
    if not image or type(name) ~= "string" then
        return
    end
    local sprite = iconAtlas[name:gsub("^Lucide:", "")]
    if sprite then
        image.ImageRectSize = Vector2.new(48, 48)
        image.ImageRectOffset = Vector2.new(sprite[2], sprite[3])
    end
end

local window = rayfield:CreateWindow({
    name = "Yvetzal",
    subtitle = subtitle,
    icon = resolveIcon("flame"),
    showName = "Yvetzal",
    showIcon = resolveIcon("flame"),
    sidebarLayout = true,
    profile = "Wyrizon & The Infernum Team",
    theme = themes[themeName] or THEME,
    translator = function(text)
        return L(text)
    end,
    locale = langCode[lang] or "en",
})
cropIcon(window.topbarIcon, "flame")
cropIcon(window.collapsedIcon, "flame")
-- Re-execution should replace the old window.
if getgenv then
    getgenv().InfernumUI = window
end
local unloadWindow = window.Unload
window.Unload = function(self)
    if self.unloaded then
        return
    end
    unload()
    unloadWindow(self)
    if getgenv and getgenv().InfernumUI == self then
        getgenv().InfernumUI = nil
        getgenv().Infernum_Unload = nil
    end
end

local function applyTheme(name)
    themeName = themes[name] and name or "Default"
    window:ChangeTheme(themes[themeName])
    if getgenv then
        getgenv().Infernum_Theme = themeName
    end
end

-- Crop icons as controls are added.
local elementMethods = {
    "CreateSection",
    "CreateToggle",
    "CreateSlider",
    "CreateDropdown",
    "CreateButton",
    "CreateColorPicker",
    "CreateText",
    "CreateInput",
    "CreateKeybind",
}
local function wrapTab(tab)
    for _, method in ipairs(elementMethods) do
        local create = tab[method]
        tab[method] = function(self, props)
            local icon = props.icon
            props.icon = resolveIcon(icon)
            local element = create(self, props)
            cropIcon(element.iconLabel, icon)
            return element
        end
    end
    return tab
end
local createTab = window.CreateTab
window.CreateTab = function(self, props)
    local icon = props.icon
    props.icon = resolveIcon(icon)
    local tab = createTab(self, props)
    cropIcon(tab.topbarItemIcon, icon)
    return wrapTab(tab)
end
local notify = window.Notify
window.Notify = function(self, props)
    local icon = props.icon
    props.icon = resolveIcon(icon)
    local notification = notify(self, props)
    if notification then
        cropIcon(notification.iconLabel, icon)
    end
    return notification
end

local tabs = {}
local homeTab = window:CreateTab({ name = "Home", icon = "Lucide:flame" })
tabs.movement = window:CreateTab({ name = "Movement", icon = "Lucide:move" })
tabs.legit = window:CreateTab({ name = "Legit", icon = "Lucide:target" })
tabs.rage = window:CreateTab({ name = "Rage", icon = "Lucide:crosshair" })
tabs.visuals = window:CreateTab({ name = "Visuals", icon = "Lucide:eye" })
tabs.weapons = window:CreateTab({ name = "Weapons", icon = "Lucide:sword" })
tabs.hvh = window:CreateTab({ name = "HvH", icon = "Lucide:skull" })
local shaderTab = window:CreateTab({ name = "Shaders", icon = "Lucide:sun" })
local miscTab = window:CreateTab({ name = "Misc", icon = "Lucide:settings" })

-- Rayfield owns the menu key listener.
window.settings.toggleKeybind = keyEnum

local function savePref(file, value)
    if getgenv then
        getgenv()["Infernum_" .. file:gsub("%.txt", "")] = value
    end
    pcall(function()
        if writefile then
            pcall(function()
                if makefolder then
                    makefolder("InfernumConfigs")
                end
            end)
            writefile("InfernumConfigs/" .. file, value)
        end
    end)
end

local function reexec()
    task.spawn(function()
        local src
        pcall(function()
            if readfile then
                src = readfile(filePath)
            end
        end)
        if (not src or #src == 0) and getgenv and getgenv().YvetzalArsenal_Source then
            src = getgenv().YvetzalArsenal_Source
        end
        if src then
            loadstring(src)()
        end
    end)
end

-- Home
do
    homeTab:CreateSection({ name = "WELCOME", icon = "Lucide:flame" })
    homeTab:CreateButton({
        name = "Yvetzal",
        description = subtitle .. " tools",
        icon = "Lucide:flame",
        callback = function()
            window:Notify({
                title = "Yvetzal",
                content = "Wyrizon & The Infernum Team",
                duration = 4,
                icon = "Lucide:flame",
            })
        end,
    })
    homeTab:CreateText({ name = plr.DisplayName, text = "@" .. plr.Name .. " - " .. subtitle })
    homeTab:CreateText({ name = "Credits", text = "Wyrizon & The Infernum Team" })
end

local creditsTab = window:CreateTab({ name = "Credits", icon = "Lucide:heart" })
creditsTab:CreateText({ name = "Yvetzal", text = "Yvetzal tools for " .. subtitle .. "." })
creditsTab:CreateText({ name = "Credits", text = "Wyrizon & The Infernum Team" })
creditsTab:CreateText({ name = "UI", text = "Sirius Rayfield Gen2" })

-- Shaders
do
    local ready = false
    task.delay(0.5, function()
        ready = true
    end)

    local origBright = light.Brightness
    local fogSaved = { light.FogEnd, light.FogStart }

    shaderTab:CreateSection({ name = "COLOR", icon = "Lucide:palette" })
    shaderTab:CreateSlider({
        name = "Game Brightness",
        range = { 0, 10 },
        value = math.clamp(origBright, 0, 10),
        increment = 0.25,
        flag = "GameBrightness",
        callback = function(v)
            light.Brightness = v
        end,
    })
    shaderTab:CreateSlider({
        name = "Luminance",
        range = { -1, 1 },
        value = 0,
        increment = 0.01,
        flag = "ShaderLuminance",
        callback = function(v)
            if ready then
                fx("ColorCorrectionEffect", "Infernum_CC").Brightness = v
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Contrast",
        range = { -1, 1 },
        value = 0,
        increment = 0.01,
        flag = "ShaderContrast",
        callback = function(v)
            if ready then
                fx("ColorCorrectionEffect", "Infernum_CC").Contrast = v
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Saturation",
        range = { -1, 1 },
        value = 0,
        increment = 0.01,
        flag = "ShaderSaturation",
        callback = function(v)
            if ready then
                fx("ColorCorrectionEffect", "Infernum_CC").Saturation = v
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Tint R",
        range = { 0, 255 },
        value = 0,
        flag = "ShaderTintR",
        callback = function(v)
            if ready then
                local cc = fx("ColorCorrectionEffect", "Infernum_CC")
                local c = cc.TintColor
                cc.TintColor = Color3.fromRGB(v, c.G, c.B)
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Tint G",
        range = { 0, 255 },
        value = 255,
        flag = "ShaderTintG",
        callback = function(v)
            if ready then
                local cc = fx("ColorCorrectionEffect", "Infernum_CC")
                local c = cc.TintColor
                cc.TintColor = Color3.fromRGB(c.R, v, c.B)
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Tint B",
        range = { 0, 255 },
        value = 255,
        flag = "ShaderTintB",
        callback = function(v)
            if ready then
                local cc = fx("ColorCorrectionEffect", "Infernum_CC")
                local c = cc.TintColor
                cc.TintColor = Color3.fromRGB(c.R, c.G, v)
            end
        end,
    })

    shaderTab:CreateSection({ name = "BLOOM", icon = "Lucide:sparkles" })
    shaderTab:CreateSlider({
        name = "Bloom Intensity",
        range = { 0, 1 },
        value = 0,
        increment = 0.01,
        flag = "BloomIntensity",
        callback = function(v)
            if ready then
                fx("BloomEffect", "Infernum_Bloom").Intensity = v
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Bloom Size",
        range = { 1, 56 },
        value = 24,
        flag = "BloomSize",
        callback = function(v)
            if ready then
                fx("BloomEffect", "Infernum_Bloom").Size = v
            end
        end,
    })
    shaderTab:CreateSlider({
        name = "Bloom Threshold",
        range = { 0, 1 },
        value = 0,
        increment = 0.01,
        flag = "BloomThreshold",
        callback = function(v)
            if ready then
                fx("BloomEffect", "Infernum_Bloom").Threshold = v
            end
        end,
    })

    shaderTab:CreateSection({ name = "EFFECTS", icon = "Lucide:wand-2" })
    shaderTab:CreateToggle({
        name = "No Fog",
        value = false,
        flag = "NoFog",
        callback = function(v)
            if v then
                light.FogEnd = 1e9
                light.FogStart = 1e9
            else
                light.FogEnd = fogSaved[1]
                light.FogStart = fogSaved[2]
            end
        end,
    })
    shaderTab:CreateToggle({
        name = "Sun Rays",
        value = false,
        flag = "SunRays",
        callback = function(v)
            if ready then
                fx("SunRaysEffect", "Infernum_SunRays").Intensity = v and 0.25 or 0
            end
        end,
    })
    shaderTab:CreateToggle({
        name = "Depth of Field",
        value = false,
        flag = "DepthOfField",
        callback = function(v)
            if ready then
                fx("DepthOfFieldEffect", "Infernum_DoF").FarIntensity = v and 0.5 or 0
            end
        end,
    })
    shaderTab:CreateToggle({
        name = "Global Shadows",
        value = false,
        flag = "GlobalShadows",
        callback = function(v)
            if ready then
                light.GlobalShadows = v
            end
        end,
    })
    shaderTab:CreateButton({
        name = "Reset Shaders",
        callback = function()
            light.Brightness = origBright
            light.FogEnd = fogSaved[1]
            light.FogStart = fogSaved[2]
            for _, n in ipairs({ "Infernum_CC", "Infernum_Bloom", "Infernum_SunRays", "Infernum_DoF" }) do
                local e = light:FindFirstChild(n)
                if e then
                    e:Destroy()
                end
            end
            light.GlobalShadows = false
        end,
    })

    onUnload(function()
        light.Brightness = origBright
        light.FogEnd = fogSaved[1]
        light.FogStart = fogSaved[2]
        for _, n in ipairs({ "Infernum_CC", "Infernum_Bloom", "Infernum_SunRays", "Infernum_DoF" }) do
            local e = light:FindFirstChild(n)
            if e then
                e:Destroy()
            end
        end
    end)
end

-- Misc
do
    miscTab:CreateSection({ name = "APPEARANCE", icon = "Lucide:palette" })
    miscTab:CreateDropdown({
        name = "Theme",
        options = { "Default", "Crimson", "Dark", "Darker" },
        value = themeName,
        flag = "Theme",
        callback = function(v)
            applyTheme(v)
            savePref("theme.txt", v)
        end,
    })
    miscTab:CreateDropdown({
        name = "Language",
        options = langList,
        value = lang,
        flag = "Lang",
        callback = function(v)
            lang = v
            savePref("lang.txt", v)
            window:SetLocale(langCode[v] or "en")
            window:Popup({
                title = "Yvetzal",
                content = langMsg[v] or langMsg.English,
                options = {
                    { text = L("Re-execute"), style = "primary", callback = reexec },
                    { text = "Later" },
                },
            })
        end,
    })

    miscTab:CreateSection({ name = "MENU", icon = "Lucide:keyboard" })
    local keyList = {}
    for k in pairs(menuKeys) do
        keyList[#keyList + 1] = k
    end
    table.sort(keyList)
    local function setKey(nk)
        nk = fixKey(nk)
        if nk == menuKey then
            return
        end
        menuKey = nk
        keyEnum = Enum.KeyCode[nk] or Enum.KeyCode.Insert
        window.settings.toggleKeybind = keyEnum
        window:SaveSettings()
        savePref("menukey.txt", nk)
    end
    miscTab:CreateDropdown({
        name = "Menu Toggle Key",
        options = keyList,
        value = menuKey,
        flag = "MenuKey",
        callback = setKey,
    })

    miscTab:CreateSection({ name = "CAMERA", icon = "Lucide:camera" })
    local camFov = 70
    track(ws:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        local cam = ws.CurrentCamera
        if cam and cam.FieldOfView ~= camFov then
            cam.FieldOfView = camFov
        end
    end))
    miscTab:CreateSlider({
        name = "FOV",
        description = "camera fov, 70 = default",
        range = { 70, 120 },
        value = 70,
        increment = 1,
        flag = "CamFOV",
        callback = function(v)
            camFov = v
            local cam = ws.CurrentCamera
            if cam then
                cam.FieldOfView = v
            end
        end,
    })
    onUnload(function()
        local cam = ws.CurrentCamera
        if cam then
            cam.FieldOfView = 70
        end
    end)

    miscTab:CreateSection({ name = "CHARACTER & SERVER", icon = "Lucide:server" })
    miscTab:CreateButton({
        name = "Reset Character",
        callback = function()
            local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
            end
        end,
    })
    miscTab:CreateButton({
        name = "Rejoin Server",
        callback = function()
            if game.JobId ~= "" then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
            else
                game:GetService("TeleportService"):Teleport(game.PlaceId, plr)
            end
        end,
    })
    local synApi = getfenv().syn
    local function hop(pick)
        local req = (synApi and synApi.request) or http_request or request or (http and http.request)
        if not req then
            return
        end
        local okr, res = pcall(req, {
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET",
        })
        if not okr or not res or not res.Body then
            return
        end
        local okj, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(res.Body)
        end)
        if not okj or type(data) ~= "table" or not data.data then
            return
        end
        local best
        for _, s in ipairs(data.data) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                if not best then
                    best = s
                elseif pick == "low" and s.playing < best.playing then
                    best = s
                elseif pick == "high" and s.playing > best.playing then
                    best = s
                end
            end
        end
        if best then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, best.id, plr)
        else
            window:Notify({ title = "Yvetzal", content = L("No server found."), duration = 4 })
        end
    end
    miscTab:CreateButton({
        name = "Server Hop",
        callback = function()
            hop("any")
        end,
    })
    miscTab:CreateButton({
        name = "Low Server",
        callback = function()
            hop("low")
        end,
    })
    miscTab:CreateButton({
        name = "High Server (not full)",
        callback = function()
            hop("high")
        end,
    })

    local function clip(txt)
        if setclipboard then
            pcall(setclipboard, txt)
            window:Notify({ title = "Yvetzal", content = L("Copied to clipboard."), duration = 3 })
        else
            window:Notify({ title = "Yvetzal", content = L("No clipboard support."), duration = 4 })
        end
    end
    miscTab:CreateButton({
        name = "Copy JobId",
        callback = function()
            clip(game.JobId)
        end,
    })
    miscTab:CreateButton({
        name = "Copy HWID",
        callback = function()
            local h = "unsupported"
            pcall(function()
                h = (synApi and synApi.gethwid and synApi.gethwid()) or (gethwid and gethwid()) or "unsupported"
            end)
            if h == "unsupported" then
                window:Notify({ title = "Yvetzal", content = L("HWID not supported."), duration = 4 })
            else
                clip(h)
            end
        end,
    })
    miscTab:CreateButton({
        name = "Copy GameId",
        callback = function()
            clip(tostring(game.GameId))
        end,
    })
    miscTab:CreateButton({
        name = "Copy User Id",
        callback = function()
            clip(tostring(plr.UserId))
        end,
    })

    miscTab:CreateSection({ name = "TOGGLES", icon = "Lucide:toggle-right" })
    local afkConn
    miscTab:CreateToggle({
        name = "Anti-AFK",
        value = false,
        flag = "AntiAFK",
        callback = function(state)
            if state then
                local vu = game:GetService("VirtualUser")
                afkConn = track(plr.Idled:Connect(function()
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                end))
            elseif afkConn then
                afkConn:Disconnect()
                afkConn = nil
            end
        end,
    })
    miscTab:CreateToggle({
        name = "Fullbright",
        value = false,
        flag = "Fullbright",
        callback = function(state)
            if state then
                light.Brightness = 2
                light.ClockTime = 14
                light.FogEnd = 1e6
                light.GlobalShadows = false
                light.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            else
                light.Brightness = 1
                light.ClockTime = 14
                light.FogEnd = 100000
            end
        end,
    })
    miscTab:CreateToggle({
        name = "Day Time",
        value = false,
        flag = "DayTime",
        callback = function(state)
            if state == true then
                light.ClockTime = 14
            else
                light.ClockTime = 0
            end
        end,
    })
    miscTab:CreateToggle({
        name = "FPS Boost",
        value = false,
        flag = "FPSBoost",
        callback = function(state)
            if not state then
                return
            end
            light.GlobalShadows = false
            light.FogEnd = 1e6
            for _, e in ipairs(light:GetChildren()) do
                if
                    e:IsA("BloomEffect")
                    or e:IsA("SunRaysEffect")
                    or e:IsA("DepthOfFieldEffect")
                    or e:IsA("BlurEffect")
                then
                    e.Enabled = false
                end
            end
        end,
    })
    local lagSaved = setmetatable({}, { __mode = "k" })
    local lagConn
    local function killTex(d)
        if d:IsA("Decal") or d:IsA("Texture") then
            if lagSaved[d] == nil then
                lagSaved[d] = d.Texture
            end
            d.Texture = ""
        elseif d:IsA("ParticleEmitter") or d:IsA("Beam") or d:IsA("Trail") then
            if lagSaved[d] == nil then
                lagSaved[d] = d.Enabled
            end
            d.Enabled = false
        end
    end
    miscTab:CreateToggle({
        name = "Anti-Lag (Remove Textures)",
        value = false,
        flag = "AntiLag",
        callback = function(v)
            if v then
                for _, d in ipairs(ws:GetDescendants()) do
                    pcall(killTex, d)
                end
                if not lagConn then
                    lagConn = track(ws.DescendantAdded:Connect(function(d)
                        pcall(killTex, d)
                    end))
                end
            else
                if lagConn then
                    lagConn:Disconnect()
                    lagConn = nil
                end
                for d, val in pairs(lagSaved) do
                    pcall(function()
                        if d:IsA("Decal") or d:IsA("Texture") then
                            d.Texture = val
                        else
                            d.Enabled = val
                        end
                    end)
                end
                lagSaved = setmetatable({}, { __mode = "k" })
            end
        end,
    })
    miscTab:CreateButton({
        name = "Unload Script",
        callback = function()
            unload()
            pcall(function()
                window:Unload()
            end)
            if getgenv then
                getgenv().Infernum_Unload = nil
                getgenv().InfernumUI = nil
            end
        end,
    })

    miscTab:CreateText({ name = "Credits", text = "Wyrizon & The Infernum Team" })
end

-- Arsenal
do
    local function wkspc(child)
        local w = rs:FindFirstChild("wkspc")
        return w and w:FindFirstChild(child)
    end
    local mTab, lTab, rTab = tabs.movement, tabs.legit, tabs.rage
    local vTab, wTab = tabs.visuals, tabs.weapons

    mTab:CreateSection({ name = "MOVEMENT", icon = "Lucide:footprints" })

    local flyCfg = { speed = 50 }
    local fly = { on = false }
    local keys = { w = false, a = false, s = false, d = false }
    local function startFly()
        fly.on = true
        local char = plr.Character
        local head = char and char:FindFirstChild("Head")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not (head and root) then
            return
        end
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.zero
        bv.Parent = head
        local bav = Instance.new("BodyAngularVelocity")
        bav.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bav.AngularVelocity = Vector3.zero
        bav.Parent = head
        fly.bv, fly.bav, fly.root, fly.head = bv, bav, root, head
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = true
        end
    end
    local function stopFly()
        fly.on = false
        if fly.bv then
            fly.bv:Destroy()
        end
        if fly.bav then
            fly.bav:Destroy()
        end
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
    track(uis.InputBegan:Connect(function(i, g)
        if g then
            return
        end
        local k = i.KeyCode.Name:lower()
        if keys[k] ~= nil then
            keys[k] = true
        end
    end))
    track(uis.InputEnded:Connect(function(i)
        local k = i.KeyCode.Name:lower()
        if keys[k] ~= nil then
            keys[k] = false
        end
    end))
    track(runSrv.Heartbeat:Connect(function(dt)
        if not fly.on then
            return
        end
        local cam = ws.CurrentCamera
        local root, head = fly.root, fly.head
        if not (root and head and root.Parent and head.Parent) then
            return
        end
        local dir = Vector3.zero
        if keys.w then
            dir = dir + cam.CFrame.LookVector
        end
        if keys.s then
            dir = dir - cam.CFrame.LookVector
        end
        if keys.a then
            dir = dir - cam.CFrame.RightVector
        end
        if keys.d then
            dir = dir + cam.CFrame.RightVector
        end
        if dir.Magnitude > 0 then
            local v = dir.Unit * flyCfg.speed
            fly.bv.Velocity = v
            root.CFrame = CFrame.new(root.Position, root.Position + cam.CFrame.LookVector)
            root:TranslateBy(v * dt)
        else
            fly.bv.Velocity = Vector3.zero
        end
    end))
    mTab:CreateToggle({
        name = "Fly",
        description = "WASD to move",
        value = false,
        flag = "Fly",
        callback = function(v)
            if v then
                startFly()
            else
                stopFly()
            end
        end,
    })
    mTab:CreateSlider({
        name = "Fly Speed",
        range = { 1, 500 },
        value = 50,
        flag = "FlySpeed",
        callback = function(v)
            flyCfg.speed = v
        end,
    })

    local walk = { on = false, speed = 16, method = "Velocity" }
    track(runSrv.Stepped:Connect(function()
        if not walk.on then
            return
        end
        local char = plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not (root and hum) then
            return
        end
        if walk.method == "Velocity" then
            root.Velocity = Vector3.new(0, root.Velocity.Y, 0)
            hum:MoveTo(root.Position + root.CFrame.LookVector * walk.speed)
        elseif walk.method == "Vector" then
            local v = hum.MoveDirection * walk.speed
            root.Velocity = Vector3.new(v.X, root.Velocity.Y, v.Z)
        elseif walk.method == "CFrame" then
            root.CFrame = CFrame.new(root.Position + hum.MoveDirection * walk.speed)
        else
            hum.WalkSpeed = walk.speed
        end
    end))
    mTab:CreateToggle({
        name = "Custom Walkspeed",
        value = false,
        flag = "WalkEnabled",
        callback = function(v)
            walk.on = v
        end,
    })
    mTab:CreateDropdown({
        name = "Walk Method",
        options = { "Velocity", "Vector", "CFrame" },
        value = "Velocity",
        flag = "WalkMethod",
        callback = function(v)
            walk.method = v
        end,
    })
    mTab:CreateSlider({
        name = "Walkspeed Power",
        range = { 16, 500 },
        value = 16,
        flag = "WalkSpeed",
        callback = function(v)
            walk.speed = v
        end,
    })

    local jump = { on = false, power = 50, method = "Default" }
    local function bindJump()
        local char = plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum then
            return
        end
        hum.Jumping:Connect(function()
            if not jump.on then
                return
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return
            end
            if jump.method == "Velocity" then
                root.Velocity = Vector3.new(root.Velocity.X, jump.power, root.Velocity.Z)
            elseif jump.method == "Vector" then
                root:ApplyImpulse(Vector3.new(0, jump.power * root.AssemblyMass, 0))
            elseif jump.method == "CFrame" then
                root.CFrame = CFrame.new(root.Position + Vector3.new(0, jump.power, 0))
            end
        end)
    end
    track(plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        bindJump()
    end))
    bindJump()
    mTab:CreateToggle({
        name = "Custom JumpPower",
        value = false,
        flag = "JumpEnabled",
        callback = function(v)
            jump.on = v
        end,
    })
    mTab:CreateDropdown({
        name = "Jump Method",
        options = { "Default", "Velocity", "Vector", "CFrame" },
        value = "Default",
        flag = "JumpMethod",
        callback = function(v)
            jump.method = v
        end,
    })
    mTab:CreateSlider({
        name = "JumpPower Value",
        range = { 30, 500 },
        value = 50,
        flag = "JumpPower",
        callback = function(v)
            jump.power = v
        end,
    })

    local infJumpConn
    mTab:CreateToggle({
        name = "Infinite Jump",
        value = false,
        flag = "InfJump",
        callback = function(v)
            if not v then
                if infJumpConn then
                    infJumpConn:Disconnect()
                    infJumpConn = nil
                end
                return
            end
            infJumpConn = track(uis.JumpRequest:Connect(function()
                local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end))
        end,
    })

    local noclipConn
    mTab:CreateToggle({
        name = "Noclip",
        value = false,
        flag = "Noclip",
        callback = function(v)
            if v then
                noclipConn = track(runSrv.Stepped:Connect(function()
                    local char = plr.Character
                    if not char then
                        return
                    end
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end))
            else
                if noclipConn then
                    noclipConn:Disconnect()
                    noclipConn = nil
                end
                fixCollision()
            end
        end,
    })
    mTab:CreateButton({
        name = "Reset Collision",
        callback = function()
            fixCollision()
        end,
    })

    local bhop = { on = false, boost = 30 }
    local bhopConn
    mTab:CreateToggle({
        name = "Bhop",
        description = "hold space to auto-hop",
        value = false,
        flag = "Bhop",
        callback = function(v)
            bhop.on = v
            if not v then
                if bhopConn then
                    bhopConn:Disconnect()
                    bhopConn = nil
                end
                return
            end
            bhopConn = track(runSrv.RenderStepped:Connect(function()
                if not (bhop.on and uis:IsKeyDown(Enum.KeyCode.Space)) then
                    return
                end
                local char = plr.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if not (root and hum) then
                    return
                end
                local sn = hum:GetState().Name
                if sn == "Landed" or sn == "Running" then
                    local cam = ws.CurrentCamera
                    if cam and root then
                        local look = cam.CFrame.LookVector
                        look = Vector3.new(look.X, 0, look.Z).Unit
                        root.Velocity = root.Velocity + (look * bhop.boost)
                    end
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end))
        end,
    })
    mTab:CreateSlider({
        name = "Bhop Boost",
        range = { 10, 100 },
        value = 30,
        flag = "BhopBoost",
        callback = function(v)
            bhop.boost = v
        end,
    })

    local debris = { on = false, sel = "Both" }
    mTab:CreateToggle({
        name = "Collect Debris",
        value = false,
        flag = "CollectDebris",
        callback = function(v)
            debris.on = v
            if not v then
                return
            end
            task.spawn(function()
                while debris.on do
                    task.wait(0.1)
                    pcall(function()
                        local root = getRoot(plr.Character)
                        local df = ws:FindFirstChild("debris")
                        if root and df then
                            for _, item in ipairs(df:GetChildren()) do
                                if debris.sel == "Both" or item.Name == debris.sel then
                                    item.CFrame = root.CFrame
                                end
                            end
                        end
                    end)
                end
            end)
        end,
    })
    mTab:CreateDropdown({
        name = "Select Object",
        options = { "DeadHP", "DeadAmmo", "Both" },
        value = "Both",
        flag = "DebrisSelect",
        callback = function(v)
            debris.sel = v
        end,
    })

    mTab:CreateSection({ name = "ANTI-AIM", icon = "Lucide:rotate-cw" })
    local spinSpd = 10
    local aaMode, aaJitter, jitterSign = "Spin", 80, 1
    local aa = { on = false, conn = nil, blockConn = nil, rotConn = nil }
    local function blockSpin(char)
        char = char or plr.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if aa.blockConn then
            aa.blockConn:Disconnect()
            aa.blockConn = nil
        end
        if aa.rotConn then
            aa.rotConn:Disconnect()
            aa.rotConn = nil
        end
        if hum then
            hum.AutoRotate = false
        end
        if not char then
            return
        end
        aa.blockConn = track(char.ChildAdded:Connect(function(c)
            if c:IsA("BodyGyro") or c:IsA("AlignOrientation") or c:IsA("BodyAngularVelocity") then
                pcall(function()
                    c:Destroy()
                end)
            end
        end))
        if hum then
            aa.rotConn = track(hum:GetPropertyChangedSignal("AutoRotate"):Connect(function()
                hum.AutoRotate = false
            end))
        end
    end
    local function unblockSpin()
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if aa.blockConn then
            aa.blockConn:Disconnect()
            aa.blockConn = nil
        end
        if aa.rotConn then
            aa.rotConn:Disconnect()
            aa.rotConn = nil
        end
        if hum then
            hum.AutoRotate = true
        end
    end
    track(plr.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        fixCollision(char)
        if aa.on then
            blockSpin(char)
        end
    end))
    mTab:CreateToggle({
        name = "Anti-Aim (Spin)",
        value = false,
        flag = "AntiAim",
        callback = function(v)
            aa.on = v
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not v then
                if aa.conn then
                    aa.conn:Disconnect()
                    aa.conn = nil
                end
                unblockSpin()
                if root then
                    root.AssemblyAngularVelocity = Vector3.zero
                end
                fixCollision(char)
                return
            end
            blockSpin()
            aa.conn = track(runSrv.Heartbeat:Connect(function()
                if not aa.on then
                    return
                end
                local c = plr.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                local hum = c and c:FindFirstChildOfClass("Humanoid")
                if not (r and hum) then
                    return
                end
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
                local st = hum:GetState().Name
                if st == "Freefall" or st == "Jumping" then
                    r.AssemblyAngularVelocity = Vector3.zero
                elseif aaMode == "Spin" then
                    r.AssemblyAngularVelocity = Vector3.new(0, spinSpd, 0)
                else
                    r.AssemblyAngularVelocity = Vector3.zero
                    local cam = ws.CurrentCamera
                    if not cam then
                        return
                    end
                    local cameraLook = cam.CFrame.LookVector
                    local look = Vector3.new(cameraLook.X, 0, cameraLook.Z)
                    if look.Magnitude < 0.01 then
                        return
                    end
                    jitterSign = -jitterSign
                    local offset = aaMode == "Jitter" and jitterSign * aaJitter or 0
                    r.CFrame = CFrame.lookAt(r.Position, r.Position - look) * CFrame.Angles(0, math.rad(offset), 0)
                end
            end))
        end,
    })
    mTab:CreateSlider({
        name = "Spin Speed",
        range = { 10, 100 },
        value = 10,
        flag = "AntiAimSpeed",
        callback = function(v)
            spinSpd = v
        end,
    })

    local tpCfg = { on = false, dist = 5, height = 2 }
    mTab:CreateToggle({
        name = "Third Person",
        value = false,
        flag = "ThirdPerson",
        callback = function(v)
            tpCfg.on = v
            if not v then
                runSrv:UnbindFromRenderStep("InfernumTP")
                return
            end
            runSrv:BindToRenderStep("InfernumTP", Enum.RenderPriority.Camera.Value + 1, function()
                if not tpCfg.on then
                    return
                end
                local cam = ws.CurrentCamera
                local char = plr.Character
                cam.CFrame = cam.CFrame * CFrame.new(0, tpCfg.height, tpCfg.dist)
                local arms = ws.Camera:FindFirstChild("Arms")
                if arms then
                    arms:PivotTo(CFrame.new(0, -9999, 0))
                end
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if (part:IsA("BasePart") or part:IsA("Decal")) and part.LocalTransparencyModifier ~= 0 then
                            part.LocalTransparencyModifier = 0
                        end
                    end
                end
            end)
        end,
    })
    mTab:CreateSlider({
        name = "TP Distance",
        description = "- = front, + = behind",
        range = { -15, 15 },
        value = 5,
        flag = "TPDistance",
        callback = function(v)
            tpCfg.dist = v
        end,
    })
    mTab:CreateSlider({
        name = "TP Height",
        range = { 0, 10 },
        value = 2,
        flag = "TPHeight",
        callback = function(v)
            tpCfg.height = v
        end,
    })

    lTab:CreateSection({ name = "HITBOX", icon = "Lucide:box-select" })
    local hb = { on = false, size = 21, trans = 6, team = "FFA", noCol = false, mode = "All" }
    local hbSaved = {}
    local function hbParts(mode)
        if mode == "Head Only" then
            return { "Head" }
        end
        if mode == "Head + Torso" then
            return { "Head", "UpperTorso", "Torso" }
        end
        return { "UpperTorso", "Head", "HumanoidRootPart" }
    end
    local function findPart(pl, name)
        local char = pl.Character
        if not char then
            return nil
        end
        for _, p in ipairs(char:GetChildren()) do
            if p:IsA("BasePart") and p.Name:lower():match(name:lower()) then
                return p
            end
        end
        return nil
    end
    local function extendHB(pl)
        for _, name in ipairs(hbParts(hb.mode)) do
            local part = pl.Character and (pl.Character:FindFirstChild(name) or findPart(pl, name))
            if part and part:IsA("BasePart") then
                if not hbSaved[pl] then
                    hbSaved[pl] = {}
                end
                if hbSaved[pl][part] == nil then
                    hbSaved[pl][part] = {
                        CanCollide = part.CanCollide,
                        Massless = part.Massless,
                        Transparency = part.Transparency,
                        Size = part.Size,
                    }
                end
                part.CanCollide = not hb.noCol
                part.Transparency = hb.trans / 10
                part.Size = Vector3.new(hb.size, hb.size, hb.size)
                for _, d in ipairs(part:GetChildren()) do
                    if d:IsA("Decal") or d:IsA("Texture") then
                        d.Transparency = hb.trans / 10
                    end
                end
            end
        end
    end
    local function restoreHB(pl)
        if not hbSaved[pl] then
            return
        end
        for part, props in pairs(hbSaved[pl]) do
            if part and part:IsA("BasePart") and part.Parent then
                part.CanCollide = props.CanCollide
                part.Massless = props.Massless
                part.Transparency = props.Transparency
                part.Size = props.Size
                for _, d in ipairs(part:GetChildren()) do
                    if d:IsA("Decal") or d:IsA("Texture") then
                        d.Transparency = props.Transparency
                    end
                end
            end
        end
        hbSaved[pl] = nil
    end
    local function updateHBs()
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local enemy = hb.team == "FFA" or hb.team == "Everyone" or p.Team ~= plr.Team
                if enemy then
                    extendHB(p)
                else
                    restoreHB(p)
                end
            end
        end
    end
    local hbLoop
    track(task.spawn(function()
        while true do
            if hb.on then
                for p in pairs(hbSaved) do
                    if not p.Parent or not p.Character or not p.Character:IsDescendantOf(game) then
                        restoreHB(p)
                    end
                end
            end
            task.wait(0.5)
        end
    end))
    track(plrs.PlayerAdded:Connect(function(p)
        p.CharacterRemoving:Connect(function()
            restoreHB(p)
        end)
    end))
    lTab:CreateToggle({
        name = "Enable Hitbox",
        value = false,
        flag = "Hitbox",
        callback = function(v)
            hb.on = v
            if not v then
                if hbLoop then
                    hbLoop:Disconnect()
                    hbLoop = nil
                end
                for _, p in ipairs(plrs:GetPlayers()) do
                    restoreHB(p)
                end
                hbSaved = {}
                return
            end
            hbLoop = track(runSrv.Stepped:Connect(function()
                if hb.on then
                    updateHBs()
                end
            end))
            updateHBs()
        end,
    })
    lTab:CreateDropdown({
        name = "Hitbox Target",
        options = { "All", "Head Only", "Head + Torso" },
        value = "All",
        flag = "HitboxMode",
        callback = function(v)
            hb.mode = v
            if hb.on then
                updateHBs()
            end
        end,
    })
    lTab:CreateSlider({
        name = "Hitbox Size",
        range = { 1, 25 },
        value = 21,
        flag = "HitboxSize",
        callback = function(v)
            hb.size = v
            if hb.on then
                updateHBs()
            end
        end,
    })
    lTab:CreateSlider({
        name = "Hitbox Transparency",
        description = "1 = visible, 10 = invisible",
        range = { 1, 10 },
        value = 6,
        flag = "HitboxTrans",
        callback = function(v)
            hb.trans = v
            if hb.on then
                updateHBs()
            end
        end,
    })
    lTab:CreateDropdown({
        name = "Team Check",
        options = { "FFA", "Team-Based", "Everyone" },
        value = "FFA",
        flag = "HitboxTeam",
        callback = function(v)
            hb.team = v
            if hb.on then
                updateHBs()
            end
        end,
    })
    lTab:CreateToggle({
        name = "No Collision",
        value = false,
        flag = "HitboxNoCol",
        callback = function(v)
            hb.noCol = v
            if hb.on then
                updateHBs()
            end
        end,
    })

    lTab:CreateSection({ name = "TRIGGERBOT", icon = "Lucide:zap" })
    local tb = { on = false, team = "Team-Based", delay = 0, holding = false }
    local function tbRayParams()
        local p = RaycastParams.new()
        p.FilterType = Enum.RaycastFilterType.Exclude
        local ignore = { plr.Character }
        for _, pl in ipairs(plrs:GetPlayers()) do
            if pl ~= plr and pl.Character then
                local hum = pl.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health <= 0 then
                    ignore[#ignore + 1] = pl.Character
                end
            end
        end
        p.FilterDescendantsInstances = ignore
        return p
    end
    local function tbTarget()
        local cam = ws.CurrentCamera
        if not cam then
            return nil
        end
        local hit = ws:Raycast(cam.CFrame.Position, cam.CFrame.LookVector * 1000, tbRayParams())
        if not hit then
            return nil
        end
        local model = hit.Instance and hit.Instance:FindFirstAncestorOfClass("Model")
        if not model then
            return nil
        end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            return nil
        end
        local tp = plrs:FindFirstChild(model.Name)
        if not (tp and tp ~= plr) then
            return nil
        end
        if tb.team == "Team-Based" and tp.Team == plr.Team then
            return nil
        end
        return tp
    end
    local tbTap, tbSeen = 0, 0
    track(runSrv.RenderStepped:Connect(function(dt)
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if not (tb.on and hum and hum.Health > 0) then
            if tb.holding then
                mouse1release()
                tb.holding = false
            end
            tbTap, tbSeen = 0, 0
            return
        end
        local now = os.clock()
        local on = tbTarget() ~= nil
        if on then
            tbSeen = now
        end
        if tb.delay <= 0 then
            local recent = (now - tbSeen) <= 0.12
            if recent and not tb.holding then
                mouse1press()
                tb.holding = true
            elseif not recent and tb.holding then
                mouse1release()
                tb.holding = false
            end
        else
            if tb.holding then
                mouse1release()
                tb.holding = false
            end
            if on then
                tbTap = tbTap - dt
                if tbTap <= 0 then
                    task.spawn(function()
                        mouse1press()
                        task.wait(0.02)
                        mouse1release()
                    end)
                    tbTap = tb.delay
                end
            else
                tbTap = 0
            end
        end
    end))
    lTab:CreateToggle({
        name = "Enable Triggerbot",
        value = false,
        flag = "Triggerbot",
        callback = function(v)
            tb.on = v
            if not v and tb.holding then
                mouse1release()
                tb.holding = false
            end
        end,
    })
    lTab:CreateDropdown({
        name = "Team Check",
        options = { "FFA", "Team-Based", "Everyone" },
        value = "Team-Based",
        flag = "TriggerbotTeam",
        callback = function(v)
            tb.team = v
        end,
    })
    lTab:CreateSlider({
        name = "Shot Delay",
        description = "0 = hold & spray, raise to tap",
        range = { 0, 2 },
        value = 0,
        increment = 0.05,
        suffix = "s",
        flag = "TriggerbotDelay",
        callback = function(v)
            tb.delay = v
            if tb.holding then
                mouse1release()
                tb.holding = false
            end
        end,
    })

    makeNLSounds(lTab)

    rTab:CreateSection({ name = "AUTOFARM", icon = "Lucide:bot" })
    local afRun = false
    local afConn, afHold = nil, false
    local function afTarget()
        local root = getRoot(plr.Character)
        if not root then
            return nil
        end
        local best, bestD
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= plr and p.TeamColor ~= plr.TeamColor and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                local hum = p.Character:FindFirstChild("Humanoid")
                if r and hum and hum.Health > 0 then
                    local d = (root.Position - r.Position).Magnitude
                    if not bestD or d < bestD then
                        best, bestD = p, d
                    end
                end
            end
        end
        return best
    end
    rTab:CreateToggle({
        name = "AutoFarm",
        description = "locks onto nearest enemy and fires (ban risk)",
        value = false,
        flag = "AutoFarm",
        callback = function(v)
            afRun = v
            if not v then
                local c = wkspc("CurrentCurse")
                if c then
                    c.Value = ""
                end
                local ts = wkspc("TimeScale")
                if ts then
                    ts.Value = 1
                end
                if afConn then
                    afConn:Disconnect()
                    afConn = nil
                end
                if afHold then
                    mouse1release()
                    afHold = false
                end
                return
            end
            local c = wkspc("CurrentCurse")
            if c then
                c.Value = "Infinite Ammo"
            end
            local ts = wkspc("TimeScale")
            if ts then
                ts.Value = 12
            end
            afConn = track(runSrv.Stepped:Connect(function()
                if not afRun then
                    return
                end
                local root = getRoot(plr.Character)
                if not root then
                    return
                end
                local cam = ws.CurrentCamera
                local t = afTarget()
                if t then
                    local r = t.Character.HumanoidRootPart
                    root.CFrame = CFrame.new(r.Position - r.CFrame.LookVector * 2 + Vector3.new(0, 2, 0))
                    local head = t.Character:FindFirstChild("Head")
                    if head and cam then
                        cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
                    end
                    if not afHold then
                        mouse1press()
                        afHold = true
                    end
                elseif afHold then
                    mouse1release()
                    afHold = false
                end
            end))
        end,
    })

    local streamer = { on = false }
    local esp = {
        on = false,
        hl = false,
        names = false,
        boxes = false,
        skel = false,
        tracers = false,
        dist = false,
        team = "Team-Based",
        teamColor = false,
        enemy = Color3.fromRGB(255, 60, 60),
        friend = Color3.fromRGB(60, 255, 120),
        gradient = false,
        gradientStart = Color3.fromRGB(255, 45, 90),
        gradientEnd = Color3.fromRGB(75, 100, 255),
        gradientSpeed = 1,
    }
    local espData, espConn = {}, nil
    local rig = {
        { "Head", "UpperTorso" },
        { "UpperTorso", "LowerTorso" },
        { "LowerTorso", "LeftUpperLeg" },
        { "LeftUpperLeg", "LeftLowerLeg" },
        { "LeftLowerLeg", "LeftFoot" },
        { "LowerTorso", "RightUpperLeg" },
        { "RightUpperLeg", "RightLowerLeg" },
        { "RightLowerLeg", "RightFoot" },
        { "UpperTorso", "LeftUpperArm" },
        { "LeftUpperArm", "LeftLowerArm" },
        { "LeftLowerArm", "LeftHand" },
        { "UpperTorso", "RightUpperArm" },
        { "RightUpperArm", "RightLowerArm" },
        { "RightLowerArm", "RightHand" },
        { "Head", "Torso" },
        { "Torso", "Left Leg" },
        { "Torso", "Right Leg" },
        { "Torso", "Left Arm" },
        { "Torso", "Right Arm" },
    }
    local function espEnemy(p)
        if esp.team == "FFA" or esp.team == "Everyone" then
            return true
        end
        if esp.team == "Team-Based" then
            if p.Team == nil and plr.Team == nil then
                return true
            end
            return p.Team ~= plr.Team
        end
        return true
    end
    local function espColor(p)
        if esp.teamColor and p.Team and p.Team.TeamColor then
            return p.Team.TeamColor.Color
        end
        if espEnemy(p) then
            return esp.enemy
        end
        return esp.friend
    end
    local gradientSegments = 8
    local function newEspLine(thickness)
        local line = Drawing.new("Line")
        line.Thickness = thickness
        line.Transparency = 1
        line.Visible = false
        return line
    end
    local function hideEspLines(lines)
        if lines then
            for _, line in ipairs(lines) do
                line.Visible = false
            end
        end
    end
    local function gradientColors()
        local phase = esp.gradientSpeed == 0 and 0 or (math.sin(os.clock() * esp.gradientSpeed) + 1) / 2
        return esp.gradientStart:Lerp(esp.gradientEnd, phase), esp.gradientEnd:Lerp(esp.gradientStart, phase)
    end
    local function drawGradientSegment(line, from, to, color)
        line.From = from
        line.To = to
        line.Color = color
        line.Visible = true
    end
    local function drawGradientBox(entry, corners, topColor, bottomColor)
        if not entry.gradientBox then
            entry.gradientBox = {}
            for i = 1, gradientSegments * 2 + 2 do
                entry.gradientBox[i] = newEspLine(1.5)
            end
        end
        local lines = entry.gradientBox
        drawGradientSegment(lines[1], corners[1], corners[2], topColor)
        drawGradientSegment(lines[2], corners[4], corners[3], bottomColor)
        for i = 1, gradientSegments do
            local startAlpha = (i - 1) / gradientSegments
            local endAlpha = i / gradientSegments
            local color = topColor:Lerp(bottomColor, (startAlpha + endAlpha) / 2)
            drawGradientSegment(
                lines[i + 2],
                corners[1]:Lerp(corners[4], startAlpha),
                corners[1]:Lerp(corners[4], endAlpha),
                color
            )
            drawGradientSegment(
                lines[i + gradientSegments + 2],
                corners[2]:Lerp(corners[3], startAlpha),
                corners[2]:Lerp(corners[3], endAlpha),
                color
            )
        end
    end
    local function drawGradientTracer(entry, from, to, startColor, endColor)
        if not entry.gradientTracer then
            entry.gradientTracer = {}
            for i = 1, gradientSegments do
                entry.gradientTracer[i] = newEspLine(1)
            end
        end
        for i, line in ipairs(entry.gradientTracer) do
            local startAlpha = (i - 1) / gradientSegments
            local endAlpha = i / gradientSegments
            drawGradientSegment(
                line,
                from:Lerp(to, startAlpha),
                from:Lerp(to, endAlpha),
                startColor:Lerp(endColor, (startAlpha + endAlpha) / 2)
            )
        end
    end
    local function rmEsp(p)
        local e = espData[p]
        if not e then
            return
        end
        if e.hl then
            pcall(function()
                e.hl:Destroy()
            end)
        end
        if e.bb then
            pcall(function()
                e.bb:Destroy()
            end)
        end
        if e.nameTxt then
            pcall(function()
                e.nameTxt:Remove()
            end)
        end
        if e.box then
            for _, l in ipairs(e.box) do
                pcall(function()
                    l:Remove()
                end)
            end
        end
        if e.lines then
            for _, l in ipairs(e.lines) do
                pcall(function()
                    l:Remove()
                end)
            end
        end
        if e.tracer then
            pcall(function()
                e.tracer:Remove()
            end)
        end
        for _, lines in ipairs({ e.gradientBox or {}, e.gradientTracer or {} }) do
            for _, line in ipairs(lines) do
                pcall(function()
                    line:Remove()
                end)
            end
        end
        espData[p] = nil
    end
    local function espTick()
        local cam = ws.CurrentCamera
        local myRoot = getRoot(plr.Character)
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= plr and p.Character then
                local char = p.Character
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
                local hum = char:FindFirstChildOfClass("Humanoid")
                local head = char:FindFirstChild("Head")
                local vis = hum and hum.Health > 0 and root and head
                local show = esp.on and espEnemy(p)
                local e = espData[p]
                if not e then
                    e = {}
                    espData[p] = e
                end
                local color = espColor(p)
                local topColor, bottomColor
                if esp.gradient then
                    topColor, bottomColor = gradientColors()
                    color = topColor:Lerp(bottomColor, 0.5)
                end

                if show and esp.hl and not streamer.on then
                    if not e.hl then
                        local h = Instance.new("Highlight")
                        h.Name = "InfernumEspHL"
                        h.Adornee = char
                        h.FillTransparency = 0.4
                        h.OutlineTransparency = 0
                        h.Parent = char
                        e.hl = h
                    end
                    e.hl.FillColor = color
                    e.hl.OutlineColor = esp.gradient and bottomColor or Color3.new(0, 0, 0)
                    e.hl.Enabled = true
                elseif e.hl then
                    e.hl.Enabled = false
                end

                if show and esp.names and not streamer.on then
                    if not e.bb or not e.bb.Parent then
                        if e.bb then
                            pcall(function()
                                e.bb:Destroy()
                            end)
                        end
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "InfernumEspName"
                        bb.Adornee = head
                        bb.AlwaysOnTop = true
                        bb.LightInfluence = 0
                        bb.Size = UDim2.new(8, 0, 2, 0)
                        bb.StudsOffset = Vector3.new(0, 2.2, 0)
                        local lbl = Instance.new("TextLabel")
                        lbl.BackgroundTransparency = 1
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.Font = Enum.Font.GothamBold
                        lbl.TextSize = 16
                        lbl.TextStrokeTransparency = 0
                        lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
                        lbl.Parent = bb
                        bb.Parent = head
                        e.bb = bb
                        e.lbl = lbl
                    end
                    e.bb.Adornee = head
                    e.lbl.TextColor3 = esp.gradient and topColor or color
                    local txt = p.DisplayName
                    if esp.dist and myRoot and vis then
                        txt = txt .. "\n[" .. math.floor((myRoot.Position - root.Position).Magnitude) .. "m]"
                    end
                    if not vis then
                        txt = p.DisplayName .. " [DEAD]"
                    end
                    e.lbl.Text = txt
                    e.bb.Enabled = true
                elseif e.bb and e.bb.Parent then
                    e.bb.Enabled = false
                end

                if show and esp.names and streamer.on and Drawing then
                    if not e.nameTxt then
                        local t = Drawing.new("Text")
                        t.Center = true
                        t.Outline = true
                        t.Font = 3
                        t.Size = 16
                        t.Color = Color3.new(1, 1, 1)
                        e.nameTxt = t
                    end
                    local sp, on
                    if head then
                        sp, on = cam:WorldToViewportPoint(head.Position)
                    end
                    if sp and on and sp.Z > 0 then
                        local txt = p.DisplayName
                        if esp.dist and myRoot and vis then
                            txt = txt .. "\n[" .. math.floor((myRoot.Position - root.Position).Magnitude) .. "m]"
                        end
                        if not vis then
                            txt = p.DisplayName .. " [DEAD]"
                        end
                        e.nameTxt.Text = txt
                        e.nameTxt.Color = esp.gradient and topColor or color
                        e.nameTxt.Position = Vector2.new(sp.X, sp.Y - 22)
                        e.nameTxt.Visible = true
                    else
                        e.nameTxt.Visible = false
                    end
                elseif e.nameTxt then
                    e.nameTxt.Visible = false
                end

                if show and esp.boxes and vis and Drawing then
                    if not esp.gradient and not e.box then
                        e.box = {}
                        for _ = 1, 4 do
                            local ln = Drawing.new("Line")
                            ln.Thickness = 1.5
                            ln.Transparency = 1
                            e.box[#e.box + 1] = ln
                        end
                    end
                    local topW = (head.CFrame * CFrame.new(0, head.Size.Y / 2 + 0.3, 0)).Position
                    local foot = char:FindFirstChild("RightFoot")
                        or char:FindFirstChild("LeftFoot")
                        or char:FindFirstChild("Right Leg")
                        or char:FindFirstChild("Left Leg")
                        or root
                    local botW = (foot.CFrame * CFrame.new(0, -foot.Size.Y / 2 - 0.3, 0)).Position
                    local hp, onH = cam:WorldToViewportPoint(topW)
                    local fp, onF = cam:WorldToViewportPoint(botW)
                    if onH and onF and hp.Z > 0 and fp.Z > 0 then
                        local topY, botY = math.min(hp.Y, fp.Y), math.max(hp.Y, fp.Y)
                        local h = botY - topY
                        local w = math.max(h * 0.55, 8)
                        local cx = (hp.X + fp.X) / 2
                        local corners = {
                            Vector2.new(cx - w / 2, topY),
                            Vector2.new(cx + w / 2, topY),
                            Vector2.new(cx + w / 2, botY),
                            Vector2.new(cx - w / 2, botY),
                        }
                        if esp.gradient then
                            hideEspLines(e.box)
                            drawGradientBox(e, corners, topColor, bottomColor)
                        else
                            hideEspLines(e.gradientBox)
                            for i = 1, 4 do
                                e.box[i].Visible = true
                                e.box[i].Color = color
                                e.box[i].From = corners[i]
                                e.box[i].To = corners[(i % 4) + 1]
                            end
                        end
                    else
                        hideEspLines(e.box)
                        hideEspLines(e.gradientBox)
                    end
                else
                    hideEspLines(e.box)
                    hideEspLines(e.gradientBox)
                end

                if show and esp.skel and Drawing then
                    if not e.lines then
                        e.lines = {}
                        for _ = 1, #rig do
                            local ln = Drawing.new("Line")
                            ln.Thickness = 2
                            ln.Transparency = 1
                            e.lines[#e.lines + 1] = ln
                        end
                    end
                    for i, bone in ipairs(rig) do
                        local line = e.lines[i]
                        local a = char:FindFirstChild(bone[1])
                        local b = char:FindFirstChild(bone[2])
                        if a and b and vis then
                            local pa, ona = cam:WorldToViewportPoint(a.Position)
                            local pb, onb = cam:WorldToViewportPoint(b.Position)
                            if ona and onb and pa.Z > 0 and pb.Z > 0 then
                                line.Visible = true
                                line.Color = esp.gradient
                                    and topColor:Lerp(bottomColor, (i - 1) / math.max(#rig - 1, 1))
                                    or color
                                line.From = Vector2.new(pa.X, pa.Y)
                                line.To = Vector2.new(pb.X, pb.Y)
                            else
                                line.Visible = false
                            end
                        else
                            line.Visible = false
                        end
                    end
                elseif e.lines then
                    for _, ln in ipairs(e.lines) do
                        ln.Visible = false
                    end
                end

                if show and esp.tracers and vis and Drawing then
                    if not esp.gradient and not e.tracer then
                        e.tracer = Drawing.new("Line")
                        e.tracer.Thickness = 1
                        e.tracer.Transparency = 1
                    end
                    local tp, on = cam:WorldToViewportPoint(head.Position)
                    if on and tp.Z > 0 then
                        local from = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        local to = Vector2.new(tp.X, tp.Y)
                        if esp.gradient then
                            if e.tracer then
                                e.tracer.Visible = false
                            end
                            drawGradientTracer(e, from, to, bottomColor, topColor)
                        else
                            hideEspLines(e.gradientTracer)
                            e.tracer.Visible = true
                            e.tracer.Color = color
                            e.tracer.From = from
                            e.tracer.To = to
                        end
                    else
                        if e.tracer then
                            e.tracer.Visible = false
                        end
                        hideEspLines(e.gradientTracer)
                    end
                else
                    if e.tracer then
                        e.tracer.Visible = false
                    end
                    hideEspLines(e.gradientTracer)
                end

                if not show then
                    if e.hl then
                        e.hl.Enabled = false
                    end
                    if e.bb then
                        e.bb.Enabled = false
                    end
                    if e.box then
                        for _, ln in ipairs(e.box) do
                            ln.Visible = false
                        end
                    end
                    if e.lines then
                        for _, ln in ipairs(e.lines) do
                            ln.Visible = false
                        end
                    end
                    if e.tracer then
                        e.tracer.Visible = false
                    end
                    hideEspLines(e.gradientBox)
                    hideEspLines(e.gradientTracer)
                end
            end
        end
    end
    local function espStop()
        if espConn then
            espConn:Disconnect()
            espConn = nil
        end
        for p in pairs(espData) do
            rmEsp(p)
        end
    end
    local function espSync()
        if esp.hl or esp.names or esp.boxes or esp.skel or esp.tracers then
            if not espConn then
                espConn = track(runSrv.RenderStepped:Connect(espTick))
            end
        else
            espStop()
        end
    end

    vTab:CreateSection({ name = "ESP", icon = "Lucide:eye" })
    vTab:CreateToggle({
        name = "Enable ESP",
        value = false,
        flag = "ESP",
        callback = function(v)
            esp.on = v
            if not v then
                espStop()
                return
            end
            esp.hl = true
            espSync()
        end,
    })
    vTab:CreateToggle({
        name = "Highlight",
        value = false,
        flag = "ESPHighlight",
        callback = function(v)
            esp.hl = v
            espSync()
        end,
    })
    vTab:CreateToggle({
        name = "Name ESP",
        value = false,
        flag = "ESPNames",
        callback = function(v)
            esp.names = v
            espSync()
        end,
    })
    vTab:CreateToggle({
        name = "Distance",
        value = false,
        flag = "ESPDistance",
        callback = function(v)
            esp.dist = v
        end,
    })
    vTab:CreateToggle({
        name = "Boxes ESP",
        value = false,
        flag = "ESPBoxes",
        callback = function(v)
            esp.boxes = v
            espSync()
        end,
    })
    vTab:CreateToggle({
        name = "Skeleton ESP",
        value = false,
        flag = "ESPSkeleton",
        callback = function(v)
            esp.skel = v
            espSync()
        end,
    })
    vTab:CreateToggle({
        name = "Tracers",
        value = false,
        flag = "ESPTracers",
        callback = function(v)
            esp.tracers = v
            espSync()
        end,
    })
    vTab:CreateDropdown({
        name = "Team Check",
        options = { "FFA", "Team-Based", "Everyone" },
        value = "Team-Based",
        flag = "ESPTeam",
        callback = function(v)
            esp.team = v
        end,
    })
    vTab:CreateToggle({
        name = "Team Color",
        value = false,
        flag = "ESPTeamColor",
        callback = function(v)
            esp.teamColor = v
        end,
    })
    vTab:CreateToggle({
        name = "Streamer Mode",
        description = "drawing ESP instead of instances",
        value = false,
        flag = "StreamerMode",
        callback = function(v)
            streamer.on = v
        end,
    })
    vTab:CreateColorPicker({
        name = "Enemy Color",
        color = Color3.fromRGB(255, 60, 60),
        flag = "ESPEnemyColor",
        callback = function(c)
            esp.enemy = c
        end,
    })
    vTab:CreateColorPicker({
        name = "Teammate Color",
        color = Color3.fromRGB(60, 255, 120),
        flag = "ESPFriendColor",
        callback = function(c)
            esp.friend = c
        end,
    })
    vTab:CreateSection({ name = "GRADIENT ESP", icon = "Lucide:palette" })
    vTab:CreateToggle({
        name = "Gradient ESP",
        description = "two-color gradient on ESP boxes and tracers, with matching overlays",
        value = false,
        flag = "ESPGradient",
        callback = function(v)
            esp.gradient = v
        end,
    })
    vTab:CreateColorPicker({
        name = "Gradient Start",
        color = Color3.fromRGB(255, 45, 90),
        flag = "ESPGradientStart",
        callback = function(c)
            esp.gradientStart = c
        end,
    })
    vTab:CreateColorPicker({
        name = "Gradient End",
        color = Color3.fromRGB(75, 100, 255),
        flag = "ESPGradientEnd",
        callback = function(c)
            esp.gradientEnd = c
        end,
    })
    vTab:CreateSlider({
        name = "Gradient Speed",
        description = "0 keeps the gradient static",
        range = { 0, 5 },
        value = 1,
        increment = 0.1,
        flag = "ESPGradientSpeed",
        callback = function(v)
            esp.gradientSpeed = v
        end,
    })
    track(plrs.PlayerRemoving:Connect(function(p)
        rmEsp(p)
    end))

    vTab:CreateSection({ name = "CHARMS", icon = "Lucide:sparkles" })
    local arm = { on = false, mat = "Plastic", color = Color3.fromRGB(50, 50, 50) }
    local gunC = { on = false, mat = "Plastic", color = Color3.fromRGB(50, 50, 50) }
    local rb = { v1 = false, v2 = false }
    local rbC, rbHue = 1, 0
    local function zigzag(x)
        return math.acos(math.cos(x * math.pi)) / math.pi
    end
    local function armLoop()
        task.spawn(function()
            while arm.on do
                task.wait(0.01)
                local arms = ws.Camera:FindFirstChild("Arms")
                if arms then
                    for _, o in ipairs(arms:GetDescendants()) do
                        if o.Name == "Right Arm" or o.Name == "Left Arm" then
                            if o:IsA("BasePart") then
                                o.Material = Enum.Material[arm.mat]
                                o.Color = arm.color
                            end
                        elseif o:IsA("SpecialMesh") then
                            if o.TextureId == "" then
                                o.TextureId = "rbxassetid://0"
                                o.VertexColor = Vector3.new(arm.color.R, arm.color.G, arm.color.B)
                            end
                        elseif o.Name == "L" or o.Name == "R" then
                            o:Destroy()
                        end
                    end
                end
            end
        end)
    end
    local function gunLoop()
        task.spawn(function()
            while gunC.on do
                task.wait(0.01)
                local arms = ws.Camera:FindFirstChild("Arms")
                if arms then
                    for _, o in ipairs(arms:GetDescendants()) do
                        if o:IsA("MeshPart") then
                            o.Material = Enum.Material[gunC.mat]
                            o.Color = gunC.color
                        end
                    end
                end
            end
        end)
    end
    track(runSrv.RenderStepped:Connect(function()
        if not rb.v1 then
            return
        end
        local arms = ws.Camera:FindFirstChild("Arms")
        if not arms then
            return
        end
        for _, v in ipairs(arms:GetDescendants()) do
            if v:IsA("MeshPart") then
                v.Color = Color3.fromHSV(zigzag(rbC), 1, 1)
            end
        end
        rbC = rbC + 0.0001
    end))
    track(runSrv.RenderStepped:Connect(function()
        if not rb.v2 then
            return
        end
        local arms = ws.Camera:FindFirstChild("Arms")
        if not arms then
            return
        end
        rbHue = (rbHue + 0.1) % 1
        for _, v in ipairs(arms:GetDescendants()) do
            if v:IsA("MeshPart") then
                v.Color = Color3.fromHSV(rbHue, 1, 1)
            end
        end
    end))
    vTab:CreateToggle({
        name = "Arm Charms",
        value = false,
        flag = "ArmCharms",
        callback = function(v)
            arm.on = v
            if v then
                armLoop()
            end
        end,
    })
    vTab:CreateDropdown({
        name = "Arm Material",
        options = { "Plastic", "ForceField", "Wood", "Grass" },
        value = "Plastic",
        flag = "ArmMaterial",
        callback = function(v)
            arm.mat = v
        end,
    })
    vTab:CreateColorPicker({
        name = "Arm Color",
        color = Color3.fromRGB(50, 50, 50),
        flag = "ArmColor",
        callback = function(c)
            arm.color = c
        end,
    })
    vTab:CreateToggle({
        name = "Gun Charms",
        value = false,
        flag = "GunCharms",
        callback = function(v)
            gunC.on = v
            if v then
                gunLoop()
            end
        end,
    })
    vTab:CreateDropdown({
        name = "Gun Material",
        options = { "Plastic", "ForceField", "Wood", "Grass" },
        value = "Plastic",
        flag = "GunMaterial",
        callback = function(v)
            gunC.mat = v
        end,
    })
    vTab:CreateColorPicker({
        name = "Gun Color",
        color = Color3.fromRGB(50, 50, 50),
        flag = "GunColor",
        callback = function(c)
            gunC.color = c
        end,
    })
    vTab:CreateToggle({
        name = "Rainbow Gun",
        value = false,
        flag = "RainbowV1",
        callback = function(v)
            rb.v1 = v
        end,
    })
    vTab:CreateToggle({
        name = "Rainbow Gun (Fast)",
        value = false,
        flag = "RainbowV2",
        callback = function(v)
            rb.v2 = v
        end,
    })

    vTab:CreateSection({ name = "WORLD", icon = "Lucide:globe" })
    local pickupData, pickupTitle, pickupConns = {}, "InfernumPickup", {}
    local function mkLabel(parent, label)
        local bb = Instance.new("BillboardGui")
        bb.Name = pickupTitle
        bb.Parent = parent
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0, 50, 0, 50)
        bb.StudsOffset = Vector3.new(0, 2, 0)
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.Text = label
        lbl.TextColor3 = Color3.new(1, 0, 0)
        lbl.Parent = bb
        return bb
    end
    local function pickupEsp(on, name, label)
        if on then
            for _, v in ipairs(ws:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent.Name == name and not v.Parent:FindFirstChild(pickupTitle) then
                    pickupData[v.Parent] = mkLabel(v.Parent, label)
                end
            end
            if not pickupConns[name] then
                pickupConns[name] = track(ws.DescendantAdded:Connect(function(d)
                    if d:IsA("TouchTransmitter") and d.Parent.Name == name then
                        if not d.Parent:FindFirstChild(pickupTitle) then
                            pickupData[d.Parent] = mkLabel(d.Parent, label)
                        end
                    end
                end))
            end
        else
            for parent, obj in pairs(pickupData) do
                if parent and obj and parent.Name == name then
                    obj:Destroy()
                    pickupData[parent] = nil
                end
            end
            if pickupConns[name] then
                pickupConns[name]:Disconnect()
                pickupConns[name] = nil
            end
        end
    end
    local xrayOn = false
    local function setXray(on)
        xrayOn = on
        for _, d in ipairs(ws:GetDescendants()) do
            if d:IsA("BasePart") then
                if on then
                    if not d:FindFirstChild("Infernum_XrayOrig") then
                        local v = Instance.new("NumberValue")
                        v.Name = "Infernum_XrayOrig"
                        v.Value = d.Transparency
                        v.Parent = d
                    end
                    d.Transparency = 0.5
                else
                    local v = d:FindFirstChild("Infernum_XrayOrig")
                    if v then
                        d.Transparency = v.Value
                        v:Destroy()
                    end
                end
            end
        end
    end
    vTab:CreateToggle({
        name = "Ammo Box ESP",
        value = false,
        flag = "AmmoBoxESP",
        callback = function(v)
            pickupEsp(v, "DeadAmmo", "Ammo Box")
        end,
    })
    vTab:CreateToggle({
        name = "HP Jug ESP",
        value = false,
        flag = "HPJugESP",
        callback = function(v)
            pickupEsp(v, "DeadHP", "HP Jug")
        end,
    })
    vTab:CreateToggle({ name = "Xray", value = false, flag = "Xray", callback = setXray })

    wTab:CreateSection({ name = "AMMO & FIRE", icon = "Lucide:zap" })
    local gun = { fastReload = false, fastFire = false, auto = false, noSpread = false, noRecoil = false }
    local gunFields = {
        fastFire = { FireRate = true, BFireRate = true, FireDelay = true },
        auto = { Auto = true, AutoFire = true, Automatic = true, AutoShoot = true, AutoGun = true },
        noSpread = { MaxSpread = true, Spread = true, SpreadControl = true },
        noRecoil = { RecoilControl = true, Recoil = true, CamShake = true },
        fastReload = { ReloadTime = true, EReloadTime = true },
    }
    local gunTargets = { fastFire = {}, auto = {}, noSpread = {}, noRecoil = {}, fastReload = {} }
    local gunLoop, gunScan
    local function gunRescan()
        for f in pairs(gunTargets) do
            gunTargets[f] = {}
        end
        local weapons = rs:FindFirstChild("Weapons")
        if not weapons then
            return
        end
        for _, w in ipairs(weapons:GetDescendants()) do
            for f, names in pairs(gunFields) do
                if names[w.Name] then
                    gunTargets[f][#gunTargets[f] + 1] = w
                end
            end
        end
    end
    local function gunOn()
        if gunLoop then
            return
        end
        gunRescan()
        if not gunScan then
            local wf = rs:FindFirstChild("Weapons")
            if wf then
                gunScan = track(wf.ChildAdded:Connect(gunRescan))
            end
        end
        gunLoop = track(runSrv.Stepped:Connect(function()
            for f, list in pairs(gunTargets) do
                if gun[f] then
                    local val = f == "auto" and true
                        or f == "fastReload" and 0.01
                        or (f == "noSpread" or f == "noRecoil") and 0
                        or 0.02
                    for _, obj in ipairs(list) do
                        obj.Value = val
                    end
                end
            end
        end))
    end
    local function gunIdle()
        if gun.fastReload or gun.fastFire or gun.auto or gun.noSpread or gun.noRecoil then
            return
        end
        if gunLoop then
            gunLoop:Disconnect()
            gunLoop = nil
        end
        if gunScan then
            gunScan:Disconnect()
            gunScan = nil
        end
    end
    wTab:CreateToggle({
        name = "Infinite Ammo v1",
        description = "infinite ammo curse",
        value = false,
        flag = "InfAmmo1",
        callback = function(v)
            local c = wkspc("CurrentCurse")
            if c then
                c.Value = v and "Infinite Ammo" or ""
            end
        end,
    })
    local ammo2Conn
    wTab:CreateToggle({
        name = "Infinite Ammo v2",
        description = "forces ammo to 99",
        value = false,
        flag = "InfAmmo2",
        callback = function(v)
            if not v then
                if ammo2Conn then
                    ammo2Conn:Disconnect()
                    ammo2Conn = nil
                end
                return
            end
            ammo2Conn = track(runSrv.Stepped:Connect(function()
                pcall(function()
                    local vars = plr.PlayerGui.GUI.Client.Variables
                    vars.ammocount.Value = 99
                    vars.ammocount2.Value = 99
                end)
            end))
        end,
    })
    wTab:CreateToggle({
        name = "Fast Reload",
        value = false,
        flag = "FastReload",
        callback = function(v)
            gun.fastReload = v
            if v then
                gunOn()
            else
                gunIdle()
            end
        end,
    })
    wTab:CreateToggle({
        name = "Fast Fire Rate",
        value = false,
        flag = "FastFire",
        callback = function(v)
            gun.fastFire = v
            if v then
                gunOn()
            else
                gunIdle()
            end
        end,
    })
    wTab:CreateToggle({
        name = "Always Auto",
        value = false,
        flag = "AlwaysAuto",
        callback = function(v)
            gun.auto = v
            if v then
                gunOn()
            else
                gunIdle()
            end
        end,
    })
    wTab:CreateSection({ name = "ACCURACY", icon = "Lucide:target" })
    wTab:CreateToggle({
        name = "No Spread",
        value = false,
        flag = "NoSpread",
        callback = function(v)
            gun.noSpread = v
            if v then
                gunOn()
            else
                gunIdle()
            end
        end,
    })
    wTab:CreateToggle({
        name = "No Recoil",
        value = false,
        flag = "NoRecoil",
        callback = function(v)
            gun.noRecoil = v
            if v then
                gunOn()
            else
                gunIdle()
            end
        end,
    })

    local hTab = tabs.hvh
    local magic = {
        on = false,
        fov = 180,
        part = "Head",
        range = 1200,
        lead = 0,
        team = true,
        visible = false,
        onlyFiring = true,
        showFov = false,
        autoFire = false,
        fireDelay = 0.15,
        syntheticShotUntil = 0,
    }
    local magicCircle, nextFire = nil, 0
    local hookState
    local targetPoint, cameraPos, rootPos, isFiring
    local previousMagicState = getgenv and getgenv().YvetzalArsenalMagicHook
    if type(previousMagicState) == "table" then
        previousMagicState.enabled = false
    end

    local function targetInFov(origin)
        local cam = ws.CurrentCamera
        if not cam then
            return nil
        end
        local center = cam.ViewportSize / 2
        local bestPart, bestPoint, bestDistance
        for _, p in ipairs(plrs:GetPlayers()) do
            if p ~= plr and p.Character and (not magic.team or not plr.Team or p.Team ~= plr.Team) then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local part = p.Character:FindFirstChild(magic.part) or p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and part and (part.Position - origin).Magnitude <= magic.range then
                    local screen, onScreen = cam:WorldToViewportPoint(part.Position)
                    local distance = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                    if
                        onScreen
                        and screen.Z > 0
                        and distance <= magic.fov
                        and (not bestDistance or distance < bestDistance)
                    then
                        local clear = true
                        if magic.visible then
                            local params = RaycastParams.new()
                            params.FilterType = Enum.RaycastFilterType.Exclude
                            params.FilterDescendantsInstances = { plr.Character }
                            local hit = ws:Raycast(origin, part.Position - origin, params)
                            clear = hit and hit.Instance and hit.Instance:IsDescendantOf(p.Character)
                        end
                        if clear then
                            bestPart, bestDistance = part, distance
                            bestPoint = part.Position + part.AssemblyLinearVelocity * (magic.lead / 1000)
                        end
                    end
                end
            end
        end
        return bestPart, bestPoint
    end

    local function updateMagicTarget()
        if not (magic.on or magic.autoFire) then
            targetPoint = nil
            return
        end
        local cam = ws.CurrentCamera
        local root = getRoot(plr.Character)
        cameraPos = cam and cam.CFrame.Position
        rootPos = root and root.Position
        isFiring = uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        if not cameraPos then
            targetPoint = nil
            return
        end
        if hookState then
            hookState.busy = true
        end
        local ok, _, point = pcall(targetInFov, cameraPos)
        if hookState then
            hookState.busy = false
        end
        targetPoint = ok and point or nil
    end
    track(runSrv.RenderStepped:Connect(updateMagicTarget))
    track(uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isFiring = true
        end
    end))
    track(uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isFiring = false
        end
    end))

    local function redirectRay(origin, direction)
        if typeof(origin) ~= "Vector3" or typeof(direction) ~= "Vector3" or direction.Magnitude < 40 then
            return nil
        end
        local nearCamera = cameraPos and (origin - cameraPos).Magnitude <= 75
        local nearCharacter = rootPos and (origin - rootPos).Magnitude <= 75
        if not (nearCamera or nearCharacter) then
            return nil
        end
        if magic.onlyFiring and not isFiring and os.clock() > magic.syntheticShotUntil then
            return nil
        end
        local point = targetPoint
        if not point then
            return nil
        end
        local aim = point - origin
        if aim.Magnitude < 1 then
            return nil
        end
        return aim.Unit * math.min(15000, math.max(direction.Magnitude, aim.Magnitude + 2))
    end

    local function installMagicHook()
        if
            type(hookmetamethod) ~= "function"
            or type(getnamecallmethod) ~= "function"
            or type(checkcaller) ~= "function"
        then
            return false
        end
        local state = hookState or previousMagicState
        if type(state) ~= "table" or state.version ~= 3 then
            if type(state) == "table" then
                state.enabled = false
            end
            state = { enabled = false, version = 3 }
            local oldNamecall
            local function intercept(self, ...)
                if state.enabled and state.pick and self == ws and not state.busy and not checkcaller() then
                    local method = getnamecallmethod()
                    local args = { ... }
                    if method == "Raycast" then
                        state.busy = true
                        local ok, direction = pcall(state.pick, args[1], args[2])
                        state.busy = false
                        if ok and direction then
                            args[2] = direction
                            return oldNamecall(self, table.unpack(args))
                        end
                    elseif
                        method == "FindPartOnRay"
                        or method == "FindPartOnRayWithIgnoreList"
                        or method == "FindPartOnRayWithWhitelist"
                    then
                        local ray = args[1]
                        if typeof(ray) == "Ray" then
                            state.busy = true
                            local ok, direction = pcall(state.pick, ray.Origin, ray.Direction)
                            state.busy = false
                            if ok and direction then
                                args[1] = Ray.new(ray.Origin, direction)
                                return oldNamecall(self, table.unpack(args))
                            end
                        end
                    end
                end
                return oldNamecall(self, ...)
            end
            local ok, original = pcall(
                hookmetamethod,
                game,
                "__namecall",
                type(newcclosure) == "function" and newcclosure(intercept) or intercept
            )
            if not ok or type(original) ~= "function" then
                return false
            end
            oldNamecall = original
            if getgenv then
                getgenv().YvetzalArsenalMagicHook = state
            end
        end
        state.pick = redirectRay
        previousMagicState = state
        hookState = state
        return true
    end

    local function updateMagicCircle()
        if not (magic.on and magic.showFov and Drawing) then
            if magicCircle then
                magicCircle:Remove()
                magicCircle = nil
            end
            return
        end
        if not magicCircle then
            magicCircle = Drawing.new("Circle")
            magicCircle.Color = Color3.fromRGB(220, 25, 25)
            magicCircle.Filled = false
            magicCircle.Thickness = 1.5
            magicCircle.NumSides = 64
        end
        local cam = ws.CurrentCamera
        if not cam then
            return
        end
        magicCircle.Position = cam.ViewportSize / 2
        magicCircle.Radius = magic.fov
        magicCircle.Visible = true
    end
    track(runSrv.RenderStepped:Connect(updateMagicCircle))

    hTab:CreateSection({ name = "MAGIC BULLET", icon = "Lucide:target" })
    local magicToggle
    magicToggle = hTab:CreateToggle({
        name = "Magic Bullet",
        description = "redirects supported client weapon rays within the FOV",
        value = false,
        flag = "Arsenal_MagicBullet",
        callback = function(v)
            magic.on = v
            if v and not installMagicHook() then
                magic.on = false
                if magicToggle then
                    magicToggle:Set(false, true)
                end
                window:Notify({ title = "Yvetzal", content = "This executor cannot hook weapon rays.", duration = 5 })
            end
            if hookState then
                hookState.enabled = magic.on
            end
            updateMagicTarget()
            updateMagicCircle()
        end,
    })
    hTab:CreateSlider({
        name = "Magic Bullet FOV",
        range = { 25, 600 },
        value = 180,
        flag = "Arsenal_MagicFov",
        callback = function(v)
            magic.fov = v
        end,
    })
    hTab:CreateToggle({
        name = "Show Magic FOV",
        value = false,
        flag = "Arsenal_MagicShowFov",
        callback = function(v)
            magic.showFov = v
            updateMagicCircle()
        end,
    })
    hTab:CreateDropdown({
        name = "Magic Aim Part",
        options = { "Head", "UpperTorso", "Torso", "HumanoidRootPart" },
        value = "Head",
        flag = "Arsenal_MagicPart",
        callback = function(v)
            magic.part = v
        end,
    })
    hTab:CreateSlider({
        name = "Magic Range",
        range = { 100, 2000 },
        value = 1200,
        flag = "Arsenal_MagicRange",
        callback = function(v)
            magic.range = v
        end,
    })
    hTab:CreateSlider({
        name = "Prediction",
        description = "target velocity lead in milliseconds",
        range = { 0, 250 },
        value = 0,
        flag = "Arsenal_MagicLead",
        callback = function(v)
            magic.lead = v
        end,
    })
    hTab:CreateToggle({
        name = "Magic Team Check",
        value = true,
        flag = "Arsenal_MagicTeam",
        callback = function(v)
            magic.team = v
        end,
    })
    hTab:CreateToggle({
        name = "Visible Targets Only",
        value = false,
        flag = "Arsenal_MagicVisible",
        callback = function(v)
            magic.visible = v
        end,
    })
    hTab:CreateToggle({
        name = "Only While Firing",
        value = true,
        flag = "Arsenal_MagicFiring",
        callback = function(v)
            magic.onlyFiring = v
        end,
    })

    hTab:CreateSection({ name = "RAGE", icon = "Lucide:zap" })
    hTab:CreateToggle({
        name = "Rage Auto Fire",
        value = false,
        flag = "Arsenal_RageAutoFire",
        callback = function(v)
            magic.autoFire = v
            updateMagicTarget()
        end,
    })
    hTab:CreateSlider({
        name = "Auto Fire Delay",
        range = { 0.05, 0.5 },
        value = 0.15,
        increment = 0.01,
        suffix = "s",
        flag = "Arsenal_RageFireDelay",
        callback = function(v)
            magic.fireDelay = v
        end,
    })
    track(runSrv.RenderStepped:Connect(function()
        if not (magic.autoFire and type(mouse1click) == "function") then
            return
        end
        local cam = ws.CurrentCamera
        local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if not (cam and hum and hum.Health > 0) or os.clock() < nextFire then
            return
        end
        if targetPoint then
            nextFire = os.clock() + magic.fireDelay
            magic.syntheticShotUntil = os.clock() + 0.12
            mouse1click()
        end
    end))

    hTab:CreateSection({ name = "ANTI-AIM", icon = "Lucide:rotate-cw" })
    hTab:CreateDropdown({
        name = "Anti-Aim Mode",
        options = { "Spin", "Jitter", "Backwards" },
        value = "Spin",
        flag = "Arsenal_AntiAimMode",
        callback = function(v)
            aaMode = v
        end,
    })
    hTab:CreateSlider({
        name = "Jitter Angle",
        range = { 0, 180 },
        value = 80,
        flag = "Arsenal_AntiAimJitter",
        callback = function(v)
            aaJitter = v
        end,
    })

    onUnload(function()
        magic.on, magic.autoFire, magic.showFov = false, false, false
        if hookState then
            hookState.enabled = false
            hookState.pick = nil
        end
        if magicCircle then
            magicCircle:Remove()
            magicCircle = nil
        end
        stopFly()
        walk.on, jump.on, bhop.on, debris.on, afRun = false, false, false, false, false
        esp.on, streamer.on = false, false
        espStop()
        setXray(false)
        if hbLoop then
            hbLoop:Disconnect()
            hbLoop = nil
        end
        for _, p in ipairs(plrs:GetPlayers()) do
            restoreHB(p)
        end
        hbSaved = {}
        unblockSpin()
        fixCollision()
        gun.fastReload, gun.fastFire, gun.auto, gun.noSpread, gun.noRecoil = false, false, false, false, false
        gunIdle()
        pcall(function()
            runSrv:UnbindFromRenderStep("InfernumTP")
        end)
    end)
end

-- Teleport reload
local function longWrap(s)
    local lvl, closer = 0, nil
    repeat
        lvl = lvl + 1
        closer = "]" .. string.rep("=", lvl) .. "]"
    until not s:find(closer, 1, true)
    return "[" .. string.rep("=", lvl) .. "[" .. s .. closer
end
local function queueReload()
    pcall(function()
        if not queue_on_teleport then
            return
        end
        local src
        pcall(function()
            if readfile then
                src = readfile(filePath)
            end
        end)
        if (not src or src == "") and getgenv and getgenv().YvetzalArsenal_Source then
            src = getgenv().YvetzalArsenal_Source
        end
        if not src or src == "" then
            return
        end
        queue_on_teleport(
            "if getgenv then getgenv().YvetzalArsenal_Source = "
                .. longWrap(src)
                .. " end\n"
                .. "local function r()\n local ok, e = pcall(function()\n"
                .. src
                .. "\n end)\n if not ok then warn('[Yvetzal] reload failed', e) end\nend\n"
                .. "if game:IsLoaded() then r() else game.Loaded:Wait() r() end"
        )
    end)
end
pcall(function()
    if getgenv and not getgenv().YvetzalArsenal_Source then
        local src
        pcall(function()
            if readfile then
                src = readfile(filePath)
            end
        end)
        if src and #src > 0 then
            getgenv().YvetzalArsenal_Source = src
        end
    end
end)
local teleHooked = false
plr.OnTeleport:Connect(function()
    if teleHooked then
        return
    end
    teleHooked = true
    queueReload()
end)

window:Notify({
    title = "Yvetzal",
    content = (loadedMsg[lang] or loadedMsg.English):format(subtitle, menuKey),
    duration = 5,
    icon = "Lucide:flame",
})
