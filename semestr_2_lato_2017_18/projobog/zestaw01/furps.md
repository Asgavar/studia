# FURPS

#### 1. Functionality
1. **Szyfrowanie** użytkowników i haseł za pomocą "co najmniej AES-256"
2. System ról - superadministrator, administratorzy, userzy
3. API przez XML-RPC po HTTPS

#### 2. Usability
1. Dostęp do systemu poprzez **konsolę web**
2. Dostęp przez aplikacje Android/iOS/WP

#### 3. Reliability
1. Synchronizacja danych między serwerem głównym a zapasowym

#### 4. Performance
1. "System musi funkcjonować w trybie wysokiej dostępności (High Availability)"

#### 5. Supportability
1. Co najmniej angielski, być może polski do wyboru przez usera
2. Naprawa w ciągu 3 dni roboczych od zgłoszenia
3. Dwa serwery, główny i backupowo-zapasowy

# Pytania
1.1. Na pewno chodzi o AES, a nie hashowanie? (*Relevant*)  
1.2. W razie incydentu bezpieczeństwa, kto odbiera uprawnienia superadministratorowi? (*Relevant*)  
1.3. Co to API ma wystawiać? (*Measurable*)

2.1. Ale co to właściwie znaczy, emulator terminala w Javascripcie? (*Specific*)  
2.2. Jakie ficzery w tych aplikacjach, pełen dostęp do wszystkich elementów systemu? Tylko trochę? (*Measurable*)

3.1. W czasie rzeczywistym, czy może backupy raz na dzień wystarczą? (*Achievable*)

4.1. Ilu użytkowników ma z tego korzystać, przynajmniej na początku? (*Measurable*)

5.1. Ewentualnego tłumaczenia musi dokonać tłumacz przysięgły, czy byle było dobrze? (*Time-specific*)  
5.2. W tym czasie system może nie działać, czy mamy naprawiać na żywca na produkcji? (*Achievable*)  
5.3. Dosłownie dwa, czy może dwa klastry i zostawiamy sobie możliwość skalowania? (*Specific*)
