Źródło danych: https://www.kaggle.com/ data: 12/21/2023

1. Wczytanie danych z pliku Excel
   - install.packages("readxl")
   - library("readxl")
   - getwd()
   - dane <- read.csv("D:/zadanie2_Kamila_Gałan/ds_salaries.csv")
   
2. Sprawdzenie czy dane wyświetlają się poprawnie
   - head(dane)
   - str(dane)

3. Zachowanie danych w strukturze data.frame
   - install.packages("openxlsx")
   - write.csv(dane, file = "ds_salaries.csv", row.names = FALSE)

4. Podsumowanie zbioru danych
   - summary(dane)

# widać dużo zmiennych typu character, które można przekształcić na "factor"
# 3 zmienne numeryczne

5. Sprawdzenie czy występują dane brakujące
   - dane[!complete.cases(dane),]

# dane brakujące nie występują

6. Przekształcanie danych kategorycznych

  6.1. Sprawdzenie czy nie ma błędów w zapisie
    - summary(factor(dane$experience_level))

  # mamy 4 kategorie danych - EN   EX   MI   SE
  
     - summary(factor(dane$employment_type))
  
  # mamy 4 kategorie danych - CT   FL   FT   PT
  
     - summary(factor(dane$company_size))
  
  # mamy 3 kategorie danych - L    M    S
  
  6.2. Konwersja danych
     - dane$experience_level <- factor(dane$experience_level, levels = c("EN", "MI", "SE", "EX"), labels = c("entry", "mid", "senior", "executive"))
     - dane$employment_type <- factor(dane$employment_type, levels = c("PT", "FT", "CT", "FL"), labels = c("part_time", "full_time", "contract", "freelance"))
     - dane$company_size <- factor(dane$company_size, levels = c("S", "M", "L"), labels = c("small", "medium", "large"))
  
     - str(dane) #sprawdzenie struktury danych
  
  #konwersja została dokonana dla 3 danych, gdyż pozostałe zawierają znacznie więcej kategorii
  
  6.3. Factor zapisany liczbami
     - summary(factor(dane$remote_ratio))
  # mamy 3 kategorie danych - 0   50   100
  
     - dane$remote_ratio <- factor(dane$remote_ratio, levels = c("0", "50", "100"), labels = c("fully_office", "hybrid", "fully_remote"))
     - str(dane) #ponowne sprawdzenie struktury danych
     - summary(dane) #podsumowanie danych #wszystko wygląda w porządku
  
  7. Podsumowanie danych liczbowych
     - zmienneLiczbowe <- c("salary") #pod uwagę zostały wzięte tylko dane liczbowe "salary", gdyż z danych "year" trudno wyciągnąć sensowne wyniki
     - install.packages("pastecs")
     - library(pastecs)
     - round(stat.desc(dane[,zmienneLiczbowe]), 0) #w danych liczbowych "salary" nie mamy miejsc po przecinku, stąd w funkcji użyto "0"
  
  Wyniki:
    nbr.val = 3755  min = 6000/per year  max = 30400000/per year   range = 30394000   sum = 716061872   median = 138000  mean = 190696  std.dev = 671677
  
  Komentarz: Średnie roczne wynagrodzenie na stanowiskach związanych z analizą danych wynosi 190 696, mediana wynosi natomiast 138 000. 
  Minimalne wynagrodzenie wynosi 6000 do maksymalnie 30 400 000 rocznie, co wskazuje na dużą różnorodność w poziomie wynagrodzeń na tym stanowisku.
  Poza tym duży rozstęp pomiędzy wartością minimalną a maksymalną, wskazuje na to, że istnieją wartości odstające. 
  Odchylenie standardowe wynosi 671 677, a im większe odchylenie tym większa zmienność wynagrodzeń. 
  
  
  8. Analiza danych kategorycznych
  
     - table(dane$experience_level, dane$employment_type) #porównanie typu pracy z poziomami stanowisk
     - table(dane$experience_level, dane$remote_ratio) #porównanie ile osób pracuje zdalnie/hybrydowo/w pełni z biura w zależności od poziomu stanowiska
  
  9. Wykresy obrazujące powyższe połaczenia
     - install.packages("ggplot2") #instalowanie pakietu ggplot2
     - library(ggplot2)
     1) mosaicplot(table(dane$experience_level, dane$remote_ratio), main = "Stosunek pracy zdalnej do stopnia stanowiska")
  
  Komantarz: Pracowników na stanowisku Seniora jest dużo więcej niż na pozostałych stanowiskach, 
  najmniej jest osób na stanowiskach (Executive), czyli na stanowiskach dyrektorskich. 
  Można też zauważyć, że Seniorzy, jak i pracownicy na stanowiskach Mid pracują albo z 100% biura albo 100% z domu. 
  Najmniej osób na tych stanowiskach pracuje hybrydowo, czyli 50/50. Z wykresu wynika też, że stanowiskiem, 
  na którym więcej niż na pozostałych pracuje się hybrydowo, jest Entry - czyli Juniorzy.
  
  10. Pozostałe wykresy
  
     2) barplot(table(dane$experience_level), main = "Rozkład doświadczenia w firmie", xlab = "Poziom doświadczenia", ylab = "Liczba pracowników", col = "lightblue")
  
  Komentarz: Wykres pokazuje jak dużo pracowników pracuje na poszczególnych stopniach zatrudnienia. Można zauważyć, że najwięcej jest pracowników pracujących jako Senior, 
  natomiast najmniej jest Executive, czyli dyrektorów. Moża zatem wywnioskować, że w firmach najbardziej potrzebne są osoby z już dużym doświadczeniem.
  
     3) pie(table(dane$remote_ratio), main = "Rozkład stosunku pracy zdalnej")
  
  Komentarz: Wykres pokazuje rozkład stosunku pracy zdalnej. Można zauważyć, że najwięcej osób pracuje 100% z biura, niewiele mniej pracuje 100% zdalnie. 
  Niewielki odsetek stanowią zaś osoby pracujące hybrydowo, czyli 50% z biura, 50% z domu.
  
  
     4) ggplot(dane, aes(x = company_size, y = salary, fill = company_size)) +
    geom_bar(stat = "summary", fun = "median") +
    labs(title = "Średnie wynagrodzenie w zależności od rozmiaru firmy", x = "Rozmiar firmy", y = "Średnie wynagrodzenie", fill = "Rozmiar firmy") +
    theme_minimal() +
    scale_y_continuous(labels = scales::number_format(scale = 1e-3, suffix = "k"))
  
  Komentarz: Z wykresu wynika, że średnie wynagrodzenie jest najwyższe w średniego rozmiaru firmach. Niewiele mniej zarabiają pracownicy największych firm.
  Najmniej natomiast zarabiają pracownicy najmniejszych firm. Może być to spowodowane wysokością kapitału firmy. Zazwyczaj im większa firma tym większy kapitał i możliwości wyższego wynagrodzenia.
  
     5) ggplot(dane, aes(x = employment_type, fill = remote_ratio)) +
    geom_bar(position = "fill") +
    labs(title = "Rozkład stosunku pracy zdalnej w zależności od rodzaju zatrudnienia", x = "Rodzaj zatrudnienia", y = "Procent pracowników", fill = "Stosunek pracy zdalnej") +
    theme_minimal()
  
  Komentarz: Z wykresu wynika, że najwięcej osób pracujących zdalnie - posiada kontrakt z firmą (np. B2B). Połowa pracowników zatrdunionych 
  na umowę o pracę (full_time) pracuje z biura i mniej niż połowa zdalnie. Można też zauważyć, że osoby zatrdunione tymczasowo (part_time)
  nie pracują w ogóle z biura. Hybrydowy tryb pracy można zauważyć u osób prowadzących własną działalność (freelance) - może to wynikać z tego, że na działalności
  osoby te posiadają własne biura lub mają zarejestrowaną działalność na swoje miejsce zamieszkania.
  