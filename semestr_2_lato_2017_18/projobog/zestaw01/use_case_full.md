# UC1: Przyjmij wpłatę gotówki

**Główny aktor:** Klient

**Interesariusze i ich cele**:
- Klient: Chce przelać na swoje konto gotówkę za pomocą bankomatu. Woli, żeby odbyło się to bez błędów, ponieważ nie chciałby stracić pieniędzy ani czasu na kontaktowanie się z pomocą techniczną.
- Operator karty płatniczej: Chce otrzymać informacje odczytane przez bankomat z karty klienta i dokonać autentykacji.
- Bank: Chce dokonać autoryzacji klienta sprawdzając, czy jego konto pozwala na wpłaty przez bankomaty, oraz otrzymać informacje o dokonanej wpłacie aby odnotować ją na koncie klienta.
- Firma odpowiedzialna za software bankomatu: W razie wystąpienia sytuacji wyjątkowej, chce otrzymać logi ze zdarzenia w celu późniejszej analizy.
- Agencja ochrony: Chce otrzymać powiadomienie o potrzebie interwencji w razie włamania.

**Warunki wstępne**: Hardware danego bankomatu pozwala na przyjmowanie wpłat.

**Warunki końcowe**: Umieszczona w bankomacie kwota zostaje zapisana na koncie klienta.

**Główny scenariusz sukcesu**:
1. Klient wsuwa kartę do bankomatu.
2. Bankomat prosi klienta o wprowadzenie numeru PIN.
3. Następuje autentykacja u operatora karty płatniczej.
4. Bankomat wyświetla menu możliwych czynności.
5. Użytkownik wybiera pozycję "Wpłać gotówkę".
6. Bankomat wyświetla klawiaturę ekranową.
7. Użytkownik wprowadza kwotę, którą zamierza wpłacić.
8. Zostaje wysłane zapytanie do banku o możliwość wpłaty wprowadzonej ilości pieniędzy.
9. Bankomat otwiera szczelinę na banknoty.
10. Klient wsuwa gotówkę do szczeliny.
11. Do banku zostaje przesłana informacja o wpłacie.
12. Bankomat drukuje potwierdzenie.

**Alternatywne przepływy zdarzeń**:
- (W dowolnym czasie)  
Bankomat wykrywa próbę włamania się do niego:
  - Agencja ochrony zostaje powiadomiona
  - Bankomat wysyła kopię logów
  - Bankomat wyłącza się i pozostaje wyłączony do czasu przybycia obsługi
- 3.a:  
Wprowadzony PIN jest nieprawidłowy:
  - Bankomat zapisuje informację o nieudanej próbie
  - Jeśli prób było mniej niż trzy:
    - Bankomat ponawia prośbę o PIN
  - W przeciwnym wypadku:
    - Bankomat wysyła kopię logów
    - Bankomat przerywa transakcję
- 8.a:  
Wprowadzona kwota jest za duża:
  - przejście do punktu 6.
- 8.b:  
Konto użytkownika nie pozwala na wpłaty:
  - Bankomat wyświetla stosowny komunikat i przerywa transakcję
