# TicTacToe

## Описание

Это игра "Крестики, нолики" в браузере. Человек против человека

## Запуск

Выполнить в терминале

`stack run`

После появившихся в терминале сообщений:

```
http://localhost:3000/
Setting phasers to stun... (port 3000) (ctrl-c to quit)
```

Игра будет доступна по http://localhost:3000/ в браузере

## Папка src/ (логика приложения)

```
src
├── HTML.hs
├── Run.hs
├── Styles.hs
└── TicTacToe
    ├── GameBoard.hs
    ├── Game.hs
    └── Player.hs
```

- HTML.hs - генерация html разметки с использованием библиотеки [blaze-html](https://hackage.haskell.org/package/blaze-html)
- Run.hs - web-сервер на [scotty](https://hackage.haskell.org/package/scotty)
- Styles.hs - css стили приложения

- TicTacToe.GameBoard.hs - игровое поле
- TicTacToe.Game.hs - обработка игрового процесса
- TicTacToe.Player.hs - игроки(X / O)
