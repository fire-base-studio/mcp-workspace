### 🚀 Архитектура арбитражного бота с MCP + LangChain

## 🎯 Phase 1: Data Layer (MCP-сервер)

---

### **Шаг 1. Определяем цели MCP-сервера**

*   MCP-сервер будет унифицировать **ценовые стримы** с одной или нескольких бирж (начнём с одной, например OKX).
*   Он будет отдавать данные в **JSON-RPC формате** по стандарту MCP.
*   Возможность расширения под несколько бирж и под Execution Module позже.

---

### **Шаг 2. Выбираем стек**

*   **Язык:** NodeJS.
*   **Фреймворк:** `Koa` + `ws` (WebSocket library).
*   **Docker:** каждый сервер в контейнере.
*   **Репозиторий:** GitHub для кода, GitHub Registry для образов.

---

### **Шаг 3. Реализация прототипа MCP-сервера**

1.  Подключение к бирже через WebSocket (OKX).
2.  Преобразование данных в **MCP-формат** (JSON-RPC, события `priceUpdate`).
3.  Простой клиент для проверки потока (можно локально).

Пример структуры MCP-сообщения:

```json
{
  "jsonrpc": "2.0",
  "method": "priceUpdate",
  "params": {
    "symbol": "BTC-USDT",
    "price": "27650.12",
    "timestamp": 1696070400
  }
}
```

---

### **Шаг 4. Docker**

*   `Dockerfile` для сервера: NodeJS + зависимости + запуск MCP-сервера.
*   Тест локального запуска: `docker build -t mcp-data-okx . && docker run -p 8000:8000 mcp-data-okx`

---

### **Шаг 5. GitHub + Registry**

1.  Репозиторий с кодом: `mcp-server-data-layer`.
2.  Workflow GitHub Actions для сборки и пуша образа в GitHub Registry.

---

### **Шаг 6. Развёртывание**

*   Развертывание Docker-образа на облачной платформе (например, GCP/Render/Fly.io).
*   Проверка, что клиент получает котировки.

---
## 🔮 Phase 2: Arbitrage Engine & Execution (TBD)
## 🤖 Phase 3: AI Layer (Risk Guard & Insights) (TBD)
