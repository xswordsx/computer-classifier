Класификация на компютри
===

Описание
---

Експертната система за класификация на компютри извежда принадлежност на
дадена машина към някой от няколко класа въз основа на въведени негови характеристики.
Необходимите входни данни са вид на машината, честота на процесора, брой ядра на процесора,
размер на RAM паметта, размер на твърдият (твърдите) диск(ове), бързина на твърдият диск,
клас на видео-картата, големина на монитора, клас на охлаждането и др.
Полученият резултат представлява класа, към който даденият компютър е съотнесен,
като тези класове са [ бизнес / сървърен / гейминг / мултимедия / интернет ].

Входни данни
---
Различните стойности на няколкото характеристики са входните данни на системата.

Схема на извод
---
Решенията на експертната система са базирани на следната таблица

Characteristics | Possible values
---------------:|:---------------
Type            | Laptop / Desktop / Rack
Processor       | Frequency Slow / Normal / Fast
Processor       | Count :number
RAM             | :number
HDD Capacity    | :number
Video Power     | Low / Medium / High
Monitor Size    | :number
Cooling         | Low / Medium / High

Работа на системата
---

При стартиране системата работи по следната последователност

	1. Системата задава последователно въпроси за всички характеристика на класифицирания
компютър. При отговор за всяка от тях се създава съответен факт, както и факт, че
съответната характеристика е проверена.

	2. След като всички характеристики са проверени се създава фактът, че всичко е проверено.

	3. Проверява се типът на компютъра и се създават факти за всеки тип, към който е
съотнесен.

	4. Проверяват се всички възможни особености за типовете, към които компютърът е
съотнесен и се създават факти за всяка от тях.

	5. Извеждат се съобщения за принадлежността на компютъра към някои от класовете и
предимствата, които той има като такъв.


