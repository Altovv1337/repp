## Mermaid: примеры диаграмм
 
Короткие универсальные примеры основных типов диаграмм Mermaid.
---
 
#### 1. Блок-схема (flowchart)
 
```mermaid
graph TD
    A[Прямоугольник] --> B{Ромб}
    B -->|Да| C[Круг]
    B -->|Нет| D((Круг))
```
 
#### 2. Блок-схема с подграфами
 
```mermaid
flowchart LR
    subgraph First [Группа 1]
        A[Шаг 1] --> B[Шаг 2]
    end
    subgraph Second [Группа 2]
        C[Шаг 3] --> D[Шаг 4]
    end
    B --> C
```
 
#### 3. Формы узлов
 
```mermaid
flowchart LR
    A[Прямоугольник]
    B(Скруглённый)
    C([Стадион])
    D[[Подпрограмма]]
    E[(База данных)]
    F((Круг))
    G{Ромб}
    H{{Шестиугольник}}
    A --> B --> C --> D
    E --> F --> G --> H
```
 
#### 4. Диаграмма последовательности (sequenceDiagram)
 
```mermaid
sequenceDiagram
    participant A as Алиса
    participant B as Боб
    A->>B: Привет, Боб!
    B-->>A: Привет, Алиса!
    A->>B: Как дела?
    B-->>A: Отлично
```
 
#### 5. Диаграмма классов (classDiagram)
 
```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +eat()
    }
    class Dog {
        +bark()
    }
    class Cat {
        +meow()
    }
    Animal <|-- Dog
    Animal <|-- Cat
```
 
#### 6. Диаграмма состояний (stateDiagram)
 
```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Running : старт
    Running --> Paused : пауза
    Paused --> Running : продолжить
    Running --> [*] : стоп
```
 
#### 7. ER-диаграмма (erDiagram)
 
```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ ITEM : contains
    USER {
        int id
        string name
    }
    ORDER {
        int id
        date created
    }
    ITEM {
        int id
        string title
    }
```
 
#### 8. Диаграмма Ганта (gantt)
 
```mermaid
gantt
    title Пример плана
    dateFormat YYYY-MM-DD
    section Этап 1
    Задача 1 :done, t1, 2026-09-01, 5d
    Задача 2 :active, t2, after t1, 7d
    section Этап 2
    Задача 3 :t3, after t2, 5d
    Задача 4 :t4, after t3, 3d
```
 
#### 9. Круговая диаграмма (pie)
 
```mermaid
pie title Пример распределения
    "Категория 1" : 40
    "Категория 2" : 30
    "Категория 3" : 20
    "Категория 4" : 10
```
 
#### 10. Пользовательский путь (journey)
 
```mermaid
journey
    title Пример пути пользователя
    section Начало
      Открывает сайт: 4: Пользователь
      Регистрируется: 3: Пользователь
    section Использование
      Выполняет задачу: 5: Пользователь
      Оставляет отзыв: 4: Пользователь
```
 
#### 11. Git-граф (gitGraph)
 
```mermaid
gitGraph
    commit id: "init"
    branch develop
    checkout develop
    commit id: "feature"
    commit id: "fix"
    checkout main
    merge develop
    commit id: "release"
```
 
#### 12. Ментальная карта (mindmap)
 
```mermaid
mindmap
  root((Тема))
    Ветка 1
      Пункт 1.1
      Пункт 1.2
    Ветка 2
      Пункт 2.1
      Пункт 2.2
    Ветка 3
      Пункт 3.1
```
 
#### 13. Хронология (timeline)
 
```mermaid
timeline
    title Пример хронологии
    2020 : Событие 1
    2022 : Событие 2
    2024 : Событие 3
    2026 : Событие 4
```