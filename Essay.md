# Реферат
## по курсу "Логическое программирование"

### студент: Харьков П.А.

## Как научить вашу бабушку/дедушку логическому программированию.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*

# Введение в логическое программирование

Для начала необходимо чуть рассказать, что представляет из себя язык программирования Пролог и вообще логическое программирование. В отличие от императивных и функциональных языков, логические языки оперируют пространством поиска решений, а также программы на них задают множество возможных переходов в пространстве поиска. Парадигмой логического языка является декларативное программирование, то есть языки основаны на ограниченной логике предикатов 1го порядка. Также в них заложена возможность возвратов и перебора, а также встроены списки и деревья.


Можно сказать, что Пролог уже довольно старый язык программирования - он появился целых 50 лет назад, а если точнее, то в 1972 году! Но нельзя сказать, что он устарел, так как он до сих пор актуален для решения различных задач, таких как задач искусственного интеллект, задач на обработку естественного языка и поиска решений. И все же уже существуют другие, более новые языки логического программирования: самый популярный и новый из них является язык Mercury. В нем совмещены парадигмы логического и функционального программирования, в нем также используется строгая типизация, которой в Прологе нет. 

# Введение

Существует несколько мнений, почему люди в пожилом возрасте мало учатся чему-то новому. Согласно опросам 2017 года в России в возрасте от 25 до 34 лет изучают новое только 23% взрослого населения, к 55-64 годам этот показатель еще ниже - 8%! К примеру, в странах Евросоюза согласно опросам 2011 года в возрасте от 55 до 64 годам изучают новое 27% населения, что в 4,5 раза больше. Значит, у еще более взрослых людей показатель еще меньше. Одной из основных причин такого низкого показателя является отсутствие мотивации в обучении и страх перед новым. Но также, к сожалению, это связано с биологическим старением: с возрастом постепенно активность мозговой деятельность понижается.

Моей бабушке сейчас 82 года, она не умеет пользоваться компьютером, так что разбираться ей будет еще сложнее. Но я постараюсь попробовать научить её логическому программированию, так как мне повезло и она любит изучать новое, но просто боится. Я решил не вдаваться в определения, а буду просто описывать возможные примеры из жизни и работы программы, мне кажется, что бабушке это будет понятнее.

Первый вопрос бабушки был таким: "И для чего же нужно логическое программирование?". Конечно, я мог ответить, что с помощью него хорошо решать задачи искуственного интеллект, задачи на обработку естественного языка и много другого, но я решил, что бабушке это не будет сначала интересно. И я решил рассказать, как хорош язык Пролог для поиска решений в какой-либо задаче. 

Моя бабушка может забыть правильный состав вкуснейших пирожков и ей придется искать нужный рецепт в большой книге рецептов, что занимает какое-то время, а пирожков то хочется! Так что сначала я постараюсь научить бабушку находить состав и пропорции ингредиентов для рецепта. Но так как бабушке я начинаю рассказывать про логическое программирование утром, то к вечеру мы вряд ли успеем разобрать все, что хотелось бы, и не успеем приготовить пирожки. Так что я решил научить бабушку не на основе рецепта пирожков, а на основе рецепта блинчиков, состав которых она уже утром найдет с помощью Пролога и приготовит! 

Рецепт блинов будет простой, на одну порцию необходимо 125 мл молока, 1/2 яйца и 50 гр муки. Приступим!

# Основы

Сначала бабушка спросила, должна ли она как-то описать, что программе выводить на экран и в каком порядке. Мне кажется, что она имела в виду такую реализацию:
```prolog
ask :- write('125 мл молока'), write('1/2 яйца'), write('50 гр муки'). 
```

И мне нужно было рассказать, что это немного не так. В данном случае мы написали, что делать программе, когда мы спросим, а не по каким свойствам ей работать. Здесь необходимо объяснить, что такое предикат и объект. И я придумал пример: `recipe(мука, 50гр)`. В данном случае предикат - `recipe`, а `мука` и `100 гр` это объекты. Объекты могут быть двух видов: определенные(константы) и неопределенные(переменные). В данном случае мы четко знаем, на каком месте находится мука, так что это определенный объект. Что такое неопределенный, я объясню чуть позже. Опишем все ингредиенты:
```prolog
recipe(молоко, 125 мл). recipe(яйцо, 1/2 шт). recipe(мука, 50 гр). 
```

И все готово! Тут мы описали только свойства, а не что и как использовать. И теперь мы приведем пример использования переменных. Мы можем использовать 3 разных запроса для поиска ингредиентов блинов:
```prolog
1 ?- recipe(молоко, 125мл).
true.
2 ?- recipe(мука, Y).
Y = 50 гр.
3 ?- recipe(X, Y).
X = молоко, Y = 125 мл ;
X = яйцо, Y = 1/2 шт ;
X = мука, Y = 50 гр.
```

Разберем этот пример особенно подробно. В первом запросе мы проверяем, что в рецепте молока необходимо взять именно 125 мл. Так как вывелось `true`, то значит, что все правильно; если бы мы ошиблись, то вывелось бы `false`. Во втором запросе мы использовали переменную: мы не знали, сколько нужно муки, и спокойно нашли решение с помощью Пролога. Также еще нужно упомянуть, что переменные в Прологе записываются с большой буквы, а константы с маленькой, так что довольно просто понять, что в данном случае `X` - переменная. А в третьем запросе мы искали решения для каждого ингредиента и в итоге получили весь список ингредиентов! Эта простота очень понравилась моей бабушке.

# Дерево решений

Итак, теперь необходимо рассказать бабушке, как работает поиск решений в данном случае. Для этого я специально нарисовал дерево решений, ведь именно так представлен поиск решений в Прологе:

![Картинка дерева решения](https://i.ibb.co/tZWZKHM/treerecipe-1.png)

В данном случае в логическом программировании просто перебираются все варианты. Сначала подставляется по X, а затем по Y. Если находится существующий предикат, где все объекты определены и правильно расставлены, то это решение. Если не существует такого предиката, то перебираем следующие варианты. Как пример я привел поиск относительно поддерева с молоком, ведь поддеревья с яйцом и мукой разбираются аналогично. Зеленым я выделил существующий предикат, объекты которого определены и правильно расставлены - это и является одним из решений поиска. Красным же я выделил те неправильные предикаты, которые, соответственно, не дают правильных решений. Вот и все!

На это мне бабушка ответила, что раз перебирает, так перебирает, это не особо интересно. И спросила, можно ли как-то не писать 3 раза предикат `recipe`, а только один раз? Для этого мне нужно будет рассказать про списки.

# Списки

Список в Прологе можно представить очень просто - это очередь в магазине. Если очередь всегда определенной длины, то мы можем сразу обратиться к первому человеку в ней. А если случайной, то, чтобы подойти к первому человеку, нам необходимо сначала пройти мимо всей остальной очереди, проходя от человеку к человеку. 

Теперь, зная это, мы можем поместить ингредиенты в список! Спросите, как? У нас будет общий список всех ингредиентов, а в нем подсписки с информацией об ингредиентах. Довольно сложно так понять, так что я покажу. Пусть у нас будет список `Pancake` в котором буду хранить все ингредиенты. Тогда он будет выглядеть так:
```prolog
Pancake = [[молоко, 125 мл], [яйцо, 1/2 шт], [мука, 50 гр]].
```

Но что теперь делать спрашивает бабушка? Как теперь работать со списком? Теперь нам нужно чуть подробнее изучить предикаты. На самом деле, они могут записываться чуть по-другому: `recipe() :- A(), B()`. Это означает, что `recipe` как бы будет решением, только если и у `A` будет решение, и в то же время у `B`. Укороченная запись `recipe(мука, 50гр)`, которую мы использовали, всегда является решением, если объекты совпадают. Теперь нам будет необходимо чуть изменить наш код:
```prolog
recipe(X, Y) :- Pancake = [[молоко, 125 мл], [яйцо, 1/2 шт], [мука, 50 гр]], go(X, Y, Pancake).
```

И что за предикат такой `go`? Моя бабушка правильно угадала, это предикат для обхода списка. Он выглядит так:
```prolog
go(X, Y, [[X, Y]|_]).
go(X, Y, [_|T]) :- go(X, Y, T).
```

Тут бабушка не поняла, слишком сложно было написано и много каких-то непонятных слов: `X`, `Y`, `T`, еще и `|` в квадратных скобках. Так что я еще чуть-чуть остановлюсь здесь. Знак `|` означает, что мы отсекаем остальной список, а `_` означает, что нам неинтересно, что в нем хранится. Давайте представим, что мы кассиры в магазине. В первой строчке мы "пробиваем" его товар и он расплачивается - это является решением. А во второй строчке мы забываем про него и берем подсписок без него и снова делаем то же самое, то есть "пробиваем" покупки у следующего покупателя и так далее. Довольно понятно! И задав тот же самый запрос `recipe(X,Y)` мы получаем ровно тот же результат, но нам не пришлось каждый раз создавать предикат.

А теперь представьте, что если еще сделать список таких списков. Получится целая кулинарная книга, и мы сможем на Прологе искать даже рецепт таким способом!

# Определение операторов

А теперь моя бабушка спросила: "Как же я смогу печь блины для 4 людей? Ведь в рецепте мы храним количество ингредиентов только на одну порцию. Не буду же я сама всё умножать!"

Тут я согласился с ней и придумал, как это можно сделать, и даже чуть упростив наш список ингредиентов. Сейчас у нас получился не очень удобный список, так как мы делаем каждый раз список списков. Приходится расставлять много квадратных скобок и запятых, что не очень удобно. Давайте представлять каждый ингредиент в таком виде: `<название ингредиента>:<количество на 1 порцию>:<размерность>`. Тогда наш список приобретет такой вид:
```prolog
Pancake = [молоко:125:мл, яйцо:(1/2):шт, мука:50:гр].
```

Мне и моей бабушке очень понравилась данная запись, она выглядит гораздо проще и ее легче записать. Но теперь усложняется основной код. Такая запись, которую мы сейчас сделали, будет непонятна Прологу, так как он не знает, как использовать знак `:`, который мы выбрали разделяющим, но мы можем определить его так:
```prolog
:- op(200, xfy, :).
```

Здесь я сначала выставляю приоритет знака относительно приоритетов других знаков, затем говорю, как разбивает этот знак выражение, а затем просто говорю, что за знак. Бабушке чуть непонятно стало, но я сказал, что потом еще расскажу подробнее.

А теперь нужно переделать код программы. Так как в списке ингредиентов теперь хранится не список, а, как бы, один элемент, то нужно разбить по нему. Думаю, что нагляднее будет понятнее. А теперь нам же нужно еще одну переменную - количество порций! Так что код преобразовали мы так:
```prolog
recipe(X, Y, N) :- Pancake = [молоко:125:мл, яйцо:(1/2):шт, мука:50:гр], go(X, Y, Pancake, N).  
go(X, Y:Z, [X:K:Z|_], N) :- Y is K * N .
go(X, Y, [_|T], N) :- go(X, Y, T, N).
```

Здесь необходимо теперь уточнить, что такое `is`. Если в Прологе сказать, что `A = 1+2`, то он не посчитает значение и `A` не будет равен 3, а будет равен 1+2. Если же мы используем `is`, то все посчитается и `A` будет равен 3. Как вы видите, мы просто разбиваем наш ингредиент на три части и умножаем количество ингредиента на количество порций. Вот и только так изменился наш код. Теперь же мы можем узнать, конечно же, сколько чего нужно для 4 порций. Но не только это! Также мы можем узнать, к примеру, сколько муки нужно для 3 порций:
```prolog
?- recipe(мука, Y, 3).
Y = 150:гр ;
```

Но, к сожалению, с таким кодом мы не узнаем, на сколько порций хватит 250 мл молока, так как `is` работает только в одну сторону, то есть, он не сможет подсчитать `250 is 125*X`. Если же мы добавим библиотеку `clpfd` и заменим `is` на `#=`, то все будет работать. Но это просто лирическое отступление.
```prolog
?- recipe(молоко, 250:мл, N).
N = 2 ;
```

# Выводы

Мне кажется, моей бабушке очень понравилось логическое программирование, ведь в нем почти не надо рассписывать шаги работы программы - она сама выполнить за тебя необходимый перебор и поиск решений. К сожалению, из-за сложности написания обработки естественного языка, я решил не рассказывать про нее. Но, мне кажется, что бабушке бы очень понравилась возможность делать запросы, такие как "сколько муки надо на 4 порции?" и "Что нужно для 2 порций?", так как это больше похоже на человеческую речь и ей это ближе.

Также было бы хорошо доделать нашу программу и сделать из нее полноценную книгу рецептов, ведь нужно будет лишь добавить несколько рецептов и все! И к этому доделать обработку языка, чтобы делать запросы "Что нужно для 2 порций блинов?". Тогда бы не понадобился никакой интернет, все любимые бабушкины рецепты были бы в одном месте, ведь свой проверенный годами рецепт гораздо лучше нового рецепта из интернета. И к моему счастью, моя бабушка не испугалась изучать логическое программирование и помогла мне выполнить мое исследование, за что я ей очень и очень благодарен.

Так что, если вы хотите научить пожилого человека чему-то новому, найдите ему или ей мотивацию для этого. Прекрасным примером является моя бабушка, мне кажется, что если бы я не придумал идею поиска ингредиентов, она бы не согласилась изучать логическое программирование. И это было чудесное время, проведенное вместе с близкими.

А вот и подоспели блины! Посмотрите, какие чудесные!

![Блины](https://static.tildacdn.com/tild6561-6139-4237-a564-386462616164/maslenica-01.jpg)

# Список литературы

1. [Почему сложно учиться в пожилом возрасте](https://newtonew.com/culture/kak-uchatsya-v-rossii-te-komu-za-50)
2. [Как научить бабушку пользоваться компьютером](https://www.npfsafmar.ru/journal/elderly-stay-home/computer-literacy)
