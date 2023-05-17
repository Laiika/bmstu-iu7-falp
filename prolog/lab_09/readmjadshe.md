# Лабораторная работа №3

## Задание 1

Создать базу знаний "предки". Варианты вопросов:

1. По имени субъекта определить всех его бабушек
2. По имени субъекта определить всех его дедушек
3. По имени субъекта определить всех его бабушек и дедушек
4. По имени субъекта определить его бабушку по материнской линии
5. По имени субъекта определить его бабушку и дедушку по материнской линии

## Задание 2

Дополнить базу знаний правилами, позволяющими найти

1. Максимум из двух чисел (без и с использованием отсечения)
2. Максимум из трех чисел (без и с использованием отсечения)

## Защита 1

Создать базу знаний "5 видов родственников". Сравнить запросы к ней на прологе, естесственном языке и графовой СУБД Neodje.

База знаний выглядит примерно следующим образом:

<img src="img/falp_lab_03.svg">

### Neo

**Как все создать**

Описала в файле `create_db.cypher`.

**Как все вывести**

```cypher
MATCH p=()-[:Child|Parent|Sibling]->() RETURN p LIMIT 30;
```

<img src="img/db.jpg">

**Как все удалить**

```cypher
match (n)
detach delete n
```

### Сравниваем всевозможные запросы

* Получить бабушек и дедушек для `child_a`.

    ```prolog
    grandparent(child_a, Grand, _, _).

    -- где
    grandparent(Child_, GrandParent_, ParentSex_, GrandParentSex_) :-
        parent(Child_, Parent_, ParentSex_),
        parent(Parent_, GrandParent_, GrandParentSex_).
    ```

    ```cypher
    match (p3:Person)-[:Parent]->(p2:Person)
    match (p2:Person)-[:Parent]->(p1:Person{name:"child_a"})
    return p3.name;
    ```


* Получить прабабушек и прадедушек для `child_a`.

    ```prolog
    grandgrandparent(child_a, GrandGrandMother, _, _, _).

    -- гдe
    grandgrandparent(Child_, GrandGrandParent_, ParentSex_, GrandParentSex_, GrandGrandParentSex_) :-
        grandparent(Child_, GrandParent_, ParentSex_, GrandParentSex_),
        parent(GrandParent_, GrandGrandParent_, GrandGrandParentSex_).
    ```

    ```cypher
    match (p4:Person)-[:Parent]->(p3:Person)
    match (p3:Person)-[:Parent]->(p2:Person)
    match (p2:Person)-[:Parent]->(p1:Person{name:"child_a"})
    return p4.name;
    ```

* Получить бабушек для `child_a`.

    ```prolog
    grandparent(child_a, Grand, _, f).

    -- где
    grandparent(Child_, GrandParent_, ParentSex_, GrandParentSex_) :-
        parent(Child_, Parent_, ParentSex_),
        parent(Parent_, GrandParent_, GrandParentSex_).
    ```

    ```cypher
    match (p3:Person{sex:"f"})-[:Parent]->(p2:Person)
    match (p2:Person)-[:Parent]->(p1:Person{name:"child_a"})
    return p3.name;
    ```

* Получить всех дедушек по материнской линии

    ```prolog
    grandparent(child_a, Grand, f, m).

    -- где
    grandparent(Child_, GrandParent_, ParentSex_, GrandParentSex_) :-
        parent(Child_, Parent_, ParentSex_),
        parent(Parent_, GrandParent_, GrandParentSex_).
    ```

    ```cypher
    match (p3:Person{sex:"m"})-[:Parent]->(p2:Person{sex:"f"})
    match (p2:Person{sex:"f"})-[:Parent]->(p1:Person{name:"child_a"})
    return p3.name;
    ```

* Найти всех детей `brother_of_father_a`

    ```prolog
    child(Child, mother_of_father_of_mother_a).

    -- где
    child(Child_, Parent_) :-
        parent(Child_, Parent_, _).
    ```

    ```cypher
    match (father:Person{name:"brother_of_father_a"})-[:Parent]->(child:Person)
    return child.name;

    // или

    match (child:Person)-[:Child]->(father:Person{name:"brother_of_father_a"})
    return child.name;
    ```

* Найти всех теть `child_a`

    ```prolog
    aunt_uncle(child_a, Aunt, _, w).

    aunt_uncle(Child_, AuntUncle_, ParentSex_, AuntUncleSex_) :-
        parent(Child_, Parent_, ParentSex_),
        sister_brother(Parent_, AuntUncle_, AuntUncleSex_).
    ```

    ```cypher
    match (child:Person{name:"child_a"})-[:Child]->(parent:Person)-[:Sibling]->(aunt:Person{sex:"f"})
    return aunt.name;
    ```

* Найти всех теть и дядь `child_c`

    ```prolog
    aunt_uncle(child_c, AuntUncle, _, _).

    aunt_uncle(Child_, AuntUncle_, ParentSex_, AuntUncleSex_) :-
        parent(Child_, Parent_, ParentSex_),
        sister_brother(Parent_, AuntUncle_, AuntUncleSex_).
    ```

    ```cypher
    match (child:Person{name:"child_c"})-[:Child]->(parent:Person)-[:Sibling]->(auntUncle:Person)
    match (auntUncle:Person)-[:Marriage]->(auntUncle1:Person)
    return auntUncle.name, auntUncle1.name;
    ```

* Найти всех кузин и кузинов `child_e`

    ```prolog
    cousin(child_a, Cousin, _).

    cousin(Child_, Cousin_, ParentSex_) :-
        aunt_uncle(Child_, AuntOrUncle_, ParentSex_, _),
        parent(Cousin_, AuntOrUncle_, _).
    ```

    ```cypher
    match (child:Person{name:"child_e"})-[:Child]->(parent:Person)-[:Sibling]->(auntUncle:Person)-[:Parent]->(cousin:Person)
    return cousin.name;
    ```
    
 ### Дерево поиска решения на prolog
 
 Попытка 1
 
 <img src="img/tree_01.svg" width="800px">
 
  Попытка 2
    
 <img src="img/tree_02.svg" width="800px">
