
# 🗺️ Roadmap обучения Flutter-стажера

## 📅 Этап 1
- [ ] Настроен Flutter + Firebase
- [ ] Использован GoRouter для навигации
- [ ] State management через Cubit/BLoC
- [ ] UI базовых экранов
- [ ] Добавлены тёмная тема и локализация

## 📅 Этап 2
- [ ] CRUD задач через Firestore
- [ ] Подключён Retrofit + внешний API (советы)
- [ ] Задачи сохранены локально (Hive)

## 📅 Этап 3
- [ ] Покрытие бизнес-логики unit тестами
- [ ] Настроен CI/CD (GitHub Actions)
- [ ] Используется GitFlow и pull requests
- [ ] Используется таск-доска (Trello/Miro)
- [ ] Финальная презентация проекта


# 📱 Task Companion — Техническое задание

## 🔧 Описание:
Приложение для управления личными задачами и целями с авторизацией, Firebase и state management через BLoC/Cubit.

## 🔌 Стек технологий:
- GoRouter для навигации
- Firebase (Auth + Firestore)
- flutter_bloc для управления состоянием
- retrofit.dart + dio для внешнего API (советы)
- Hive / SharedPreferences для локального хранилища
- intl для локализации
- GitHub + GitFlow + CI

## 🎯 User Stories:

### Базовые:
- Я как пользователь хочу добавлять/удалять задачи
- Я хочу видеть список задач и фильтровать по статусу
- Я хочу зарегистрироваться и авторизоваться

### Средняя сложность:
- Я хочу видеть цели недели и месяца
- Я хочу переключать тему и язык
- Я хочу видеть статистику выполненных задач

### Продвинутые:
- Я хочу прикреплять медиа к задачам (опционально)
- Я как разработчик хочу видеть CI, тесты и документацию
