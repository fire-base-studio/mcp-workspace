import Koa from 'koa';
import http from 'http';
import WebSocket from 'ws';

const app = new Koa();

app.use(async ctx => {
  ctx.body = 'MCP Web Server is running.';
});

const server = http.createServer(app.callback());
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  console.log('Client connected');

  const interval = setInterval(() => {
    const dummy_price = {
      jsonrpc: '2.0',
      method: 'priceUpdate',
      params: {
        symbol: 'xautusdt',
        price: '65000.50',
        timestamp: Date.now(),
      },
    };
    ws.send(JSON.stringify(dummy_price));
  }, 5000);

  ws.on('close', () => {
    console.log('Client disconnected');
    clearInterval(interval);
  });

  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
    clearInterval(interval);
  });
});

const PORT = process.env.PORT || 8000;
server.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});
