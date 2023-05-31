# Organizeer deze map zoals je zelf wenst

## Bij het uitvoeren van deze app

Dit project is gemaakt in Visual Studio Code.
Android emulator via Android Studio.

Om dit project te kunnen runnen, moet je Flutter installeren (https://docs.flutter.dev/get-started/install).
Volg aandachtig de stappen en voer ook de Android setup uit.

Deze app kan volledig standalone werken zonder enige andere projecten te moeten starten. 
Alhoewel deze app gebruik maakt van een API (https://github.com/howest-gp-imi/st-2223-1-d-imi-project-louisboret) die ik zelf heb geschreven en ook bij mij lokaal staat, kan de app verder zonder. (Als verbinding met de API niet werkt, wordt de mockrepository vanzelf aangeroepen.)

## De app

De app start met een aanmeld scherm waarbij je kan inloggen via een bottomsheet met de code '1111' of met je vingerafdruk als deze beschikbaar is.

Je komt terecht op de homescreen met bottomnavigation. 

### Beer tab
De beer Tab laad verschillende biertjes in via Firebase. 

Hier kan je bdrankjes bestellen. De bestelling komt terecht op mijn firebase cloud_firestore database. Die bestelling kan bekeken worden op mijn volgende app voor de cafetaria(nog niet in development).

Als je op het info icoontje klikt, kan je ook de biertjes zien van mijn Api(IMI project). Als deze Api niet beschikbaar is worden er mock biertjes ingeladen.
De code voor deze pagina is gestructureerd met het MVVM pattern en opgedeeld in verschillende widgets.

### Casino tab

De tweede Tab is de main course van mijn app. Deze bevat de Slotmachine. De slot, (Gems Bonanza) is gebaseerd op sweet bonanza, met een paar verschillen.
De bedoeling is dat de gebruiker de spin knop tapt. Als er 8x van hetzelfde symbool verschijnen, ongeacht van waar ze staan op de grid, wint de gebruiker (fake) geld. Elke spin kost 100 fake dollars. Als er 4x het bonus symbool verschijnt, dan wordt de gebruiker meegenomen naar de bonusgame. Deze is in essentie hetzelfde als de base game, maar hier zijn de spins gratis en kunnen er multipliers verschijnen die elke win vermenigvuldigen. De game bevat ook een 'Bonus Buy' knop voor de ongeduldigen die onmiddelijk naar de bonusgame willen gaan.

#### animaties slotmachine

Elke keer dat er gespinned wordt, worder alle symbolen in de grid gedropt. Deze animatie heb ik verkregen (met veel frustratie en research) met de animated list widget. Deze zorgt ervoor dat elke widget die in de animated list toegevoegd wordt, een drop in animatie krijgt.

Als er 8x hetzelfde symbool op het speelveld staan, doen deze symbolen een scale animatie. Deze heb ik kunnen animeren met behulp van de flutter_animate package. die mij toeliet een animatie te spelen achter een specefieke event.

##### frustraties animaties

De bedoeling was als er een win gebeurt met 8x hetzelfde symbool, dan verdwijnen deze en die worden vervangen met nieuwe symbolen, waarmee ook zou kunnen gewonnen worder. Het is mij echter niet gelukt om de win animatie een tweede keer te kunnen afspelen tijdens dezelfde spin. De code die dit idee zou waarmaken is aanwezig in het project, maar wordt momenteel niet gebruikt doordat de animaties niet werken op degewilde manier. Vandaar de keuze dat er maar 1 symbool kan winnen per spin.

### Profiel tab

De profiel pagina bevat mock gegevens van de gebruiker. Ik had deze er ingestoken om te leren hoe je een layout bouwt in Flutter.

De tab bevat ook een profielfoto. Aan deze foto hangt een badge waarmee je de foto kan veranderen. De camera van je toestel opent en wanneer je een foto trekt, wordt deze opgeslagen in de appdata (shared_preferences). De volgende keer dat je dus de app opent, krijg je dus altijd dezelfde foto die je toen trok. Tenzij je de appdata cleared.

### Beer Service

Deze Service wordt gebruikt om verbinding te maken met de API en retourneerd de response.

