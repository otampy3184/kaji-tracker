const express = require('express');
const { Pool } = require('pg');

// Express アプリの初期化
const app = express();
app.use(express.json());

// PostgreSQL への接続設定（環境変数 DATABASE_URL を優先、なければローカル設定を使用）
const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgres://myuser:mypassword@localhost:5432/kajitracker'
});

// 接続確認用エンドポイント
app.get('/api/ping', async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    client.release();
    res.json({ time: result.rows[0].now });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB接続エラー' });
  }
});

// ルートの設定：routes フォルダ内のエンドポイントを利用
const kajisRouter = require('./routes/kajis')(pool);
const usersRouter = require('./routes/users')(pool);

app.use('/api/kajis', kajisRouter);
app.use('/api/users', usersRouter);

// サーバーの起動
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`start backend server at ${PORT}`);
});