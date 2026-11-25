// Лаб 3: тестлэх локал API. Гурван endpoint, тус бүр өөр "зан төлөвтэй".
// Ажиллуулах: npm install && node server.js   (http://localhost:3000)
const express = require('express');
const app = express();
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// 1) Хурдан endpoint: сагсанд нэмэх
app.post('/cart/add', (req, res) => res.json({ ok: true, items: 1 }));

// 2) Удаан endpoint: тайлан (200-400 мс санамсаргүй хугацаагаар удаашруулна)
app.get('/report', async (req, res) => {
  await sleep(200 + Math.random() * 200);
  res.json({ rows: 20000 });
});

// 3) Найдваргүй endpoint: төлбөр (хүсэлтийн ~5% нь 500 алдаа буцаана)
app.post('/pay', (req, res) => {
  if (Math.random() < 0.05) return res.status(500).json({ error: 'gateway timeout' });
  res.json({ paid: true });
});

app.listen(3000, () => console.log('API: http://localhost:3000'));
