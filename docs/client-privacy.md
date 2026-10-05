# Caramba Connect — Privacy / Конфиденциальность

[Русский](#русский) · [English](#english)

Version 1 · 5 October 2026 · applies to Caramba Connect 0.9.98 store candidates
and the corresponding direct client. This document describes the client. An
operator's VPN service and account panel require their own privacy policy.

## Русский

### Кто обрабатывает данные

Caramba Connect — приложение для подключения по конфигурации, которую вы
добавляете. Оно не определяет единого оператора для всех пользователей.
Сервер подписки, VPN-серверы, DNS и панель аккаунта выбираются вашей
конфигурацией и настройками. Добавляйте конфигурации только тех операторов,
которым доверяете. Для вопросов о самом клиенте: Telegram
[@caramba_support](https://t.me/caramba_support).

Оператор получает данные, необходимые для выбранных функций. Он определяет
хранение данных на своих серверах. Caramba Connect не может подтвердить
отсутствие журналов у каждого стороннего оператора.

### Что использует приложение

| Данные | Для чего и кому передаются |
| --- | --- |
| Сетевой трафик и DNS-запросы | Системный VPN обрабатывает трафик устройства. Выбранный правилами трафик направляется через серверы конфигурации, DNS — к выбранным DNS-серверам. Получатели видят сетевой IP и обрабатывают соединения. Работа продолжается в фоне, пока VPN включён. Прямые маршруты обходят VPN; способ защиты соединения зависит от конфигурации и протокола. |
| Ссылка подписки и ключ доступа | Передаются серверу подписки при импорте и обновлении для получения конфигурации. Ссылки могут содержать секретный токен: не публикуйте их. |
| Данные входа и аккаунта | Выбранная панель получает данные, которые нужны для входа, например email/пароль или Telegram-авторизацию. В прямой версии регистрация также может передавать имя и код приглашения. В подготовленных версиях для магазинов создание аккаунта в клиенте отключено. |
| Данные устройства и приложения | Запросы аккаунта содержат постоянный идентификатор устройства, его имя и платформу; API-запросы содержат версию клиента. Панель может сохранять последний IP, время доступа и сведения об устройствах для авторизации, ограничений и управления подпиской. |
| Конфигурации и настройки | Система обмена конфигурациями может передавать адрес подписки, отпечаток открытого ключа устройства, версии документов, запросы каталога и изменения предпочтений оператору. |
| Подписка и использование | Панель может хранить тарифы, сроки, статусы и счётчики объёма трафика. Это не равнозначно обещанию, что оператор не хранит другие сетевые журналы. |
| Поддержка | Встроенные обращения передают панели тему, категорию, сообщение и идентификатор запроса; ответы передают текст сообщения. Журналы и файлы не прикладываются автоматически. Если вы отдельно отправляете скриншоты, конфигурации или файлы через Telegram либо другую поддержку, их получает выбранный вами адресат. |
| Оплата в прямой версии | Если вы используете внешний платёжный переход, панель получает заказ, срок и выбранного провайдера, а провайдер обрабатывает оформление оплаты. В подготовленных версиях для магазинов эти покупки и платёжные переходы отключены. |

### Что хранится на устройстве

Основные профили и токены приложение сохраняет через защищённое хранилище
платформы. Для работы VPN нативное ядро также хранит конфигурацию и данные
сеанса в закрытой области приложения или системных настройках VPN. Например,
на Android данные сеанса передаются через приватные настройки приложения,
а собранная конфигурация записывается в рабочий каталог ядра; на Apple
используются также настройки VPN-провайдера. Не все эти копии зашифрованы
отдельно. Настройки и номер принятой версии уведомления хранятся в локальных
предпочтениях. В системных журналах могут оставаться технические сведения:
например, Android записывает ошибки VPN и недоступные приложения из правил
маршрутизации. Проверьте содержимое диагностики перед тем, как её кому-либо
передавать. Клиент не прикрепляет эти журналы к обращениям автоматически.

Разрешение камеры используется для QR-кода подключения. Выбранный файл
используется для импорта конфигурации. На Android сведения об установленных
приложениях используются для выбора правил раздельной маршрутизации.
Ни сканирование QR-кода, ни выбор файла не требуют передачи изображения
камеры или исходного файла в отдельный аналитический сервис.

В проверенной конфигурации клиента нет встроенных рекламных или
аналитических SDK. Это не означает, что сетевые запросы не содержат данных
или что серверы вашего оператора ничего не сохраняют. Магазины приложений,
операционная система, Telegram и сайты, которые вы открываете отдельно,
действуют по собственным правилам.

### Согласие, хранение и удаление

В версиях для магазинов уведомление о данных показывается до запуска
обычного интерфейса, фонового обновления аккаунта и первого VPN-подключения.
Продолжение требует отдельного действия «Согласиться и продолжить».
«Не сейчас» не запускает новое подключение; доступны текст политики и
повторный просмотр решения. Согласие сохраняется только локально, с номером
версии уведомления. При изменении этой версии запрос показывается заново.
Системное разрешение VPN запрашивается отдельно. Уже работающее системное
подключение может продолжаться независимо от открытого окна приложения;
его можно остановить в системных настройках VPN.

«Отключить» останавливает VPN. Удаление подключения удаляет локальный
профиль, выход завершает сеанс аккаунта. **Это не удаление аккаунта на
сервере.** Для доступа, исправления и удаления серверных данных обратитесь
к оператору вашей панели. Узнайте у него сроки хранения, работу с резервными
копиями, платёжными записями и обращениями: общего подтверждённого срока
для всех независимых операторов нет. Удаление приложения также не является
запросом на удаление серверного аккаунта и не гарантирует очистку всех
записей системного защищённого хранилища.

Политика доступна в настройках клиента. Существенные изменения обработки
данных должны отражаться в новой редакции документа и уведомлении в клиенте.

## English

### Who processes your data

Caramba Connect connects using configurations that you add. There is no
single operator for every user. Your configuration and settings select the
subscription server, VPN endpoints, DNS resolvers and account panel. Only
add configurations from operators you trust. For questions about the client,
contact Telegram [@caramba_support](https://t.me/caramba_support).

Your operator receives data needed for the functions you use and controls
its server-side retention. Caramba Connect cannot verify that every
third-party operator keeps no logs.

### Data and purposes

| Data | Purpose and recipient |
| --- | --- |
| Network traffic and DNS requests | The system VPN processes device traffic. Traffic selected by your rules is routed through configured servers; DNS requests go to selected resolvers. Recipients can see the network IP and process connections. This continues in the background while the VPN is active. Direct routes bypass the VPN; transport protection depends on the configuration and protocol. |
| Subscription address and access token | Sent to the subscription server when importing or refreshing configuration. These URLs may contain secret tokens; do not publish them. |
| Sign-in and account data | Your panel receives information needed for sign-in, such as email/password or Telegram authorization. Registration in the direct client can also send a name and invitation code. In-client account creation is disabled in the prepared store builds. |
| Device and app information | Account requests include a persistent device identifier, device name and platform. API requests include the app version. The panel can retain last IP, access time and device records for authorization, limits and subscription management. |
| Configuration exchange | Configuration exchange may send subscription locators, device public-key fingerprints, document versions, catalog requests and preference changes to the operator. |
| Subscription and usage | A panel can retain plans, validity periods, statuses and traffic-volume counters. This is not a promise that the operator retains no other network logs. |
| Support | In-app tickets send a subject, category, message and request identifier to the panel; replies send their text. Logs and files are not attached automatically. Screenshots, configurations or files you separately send through Telegram or other support channels go to the recipient you choose. |
| Purchases in direct builds | If you use external checkout, the panel receives the order, duration and chosen provider, and the provider handles checkout. These purchases and checkout links are disabled in the prepared store builds. |

### Data on your device

The app saves its main profile and token records using platform secure
storage. To run the VPN, the native core also keeps configuration and session
data in private app storage or system VPN settings. On Android, for example,
session data passes through private app preferences and the assembled
configuration is written to the core work directory; Apple also uses VPN
provider settings. Not every copy is separately encrypted. Preferences and
the accepted disclosure version are stored locally. System diagnostics
may contain technical details; for example, Android logs VPN errors and
unavailable apps referenced in routing rules. Review diagnostics before
sharing them. The client does not automatically attach these logs to tickets.

Camera permission is used to scan a connection QR code. A selected file is
used to import configuration. On Android, installed-app information is used
to select split-routing rules. Scanning a QR code or selecting a file does
not require uploading camera imagery or the original file to a separate
analytics service.

The reviewed client configuration contains no integrated advertising or
analytics SDK. This does not mean network requests contain no data or that
operator servers retain nothing. App stores, the operating system, Telegram
and websites you open separately follow their own policies.

### Consent, retention and deletion

Store builds show the disclosure before mounting the normal app interface,
refreshing accounts in the background or starting the first VPN connection.
Continuing requires the separate “Agree and continue” action. “Not now”
does not start a new connection and lets you read the policy or reconsider. Your
decision and disclosure version are stored locally. A new disclosure version
requires a fresh decision. The system VPN permission is separate. An existing system VPN connection
may continue independently of the app window; you can stop it in the
system VPN settings.

Disconnect stops the VPN. Removing a connection removes its local profile;
signing out ends the account session. **Neither deletes the server account.**
Ask your panel operator for access to, correction or deletion of its records.
Ask that operator about retention, backups, payment records and support
messages: there is no verified common retention period for all independent
operators. Uninstalling the client is not a server account-deletion request
and does not guarantee that all platform secure-storage records are cleared.

This policy is available from client settings. Material changes in data use
must be reflected in an updated policy and in-client disclosure.
