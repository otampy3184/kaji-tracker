const express = require('express');
const { Pool } = require('pg');
const kajisRouter = require('./routes/kajis');
const usersRouter = require('./routes/users');
const kajiRecordsRouter = require('./routes/kaji_records');

const app = express();
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgres://myuser:mypassword@localhost:5432/kajitracker'
});

app.get('/api/ping', async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    client.release();
    res.json({ time: result.rows[0].now });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'DB connection error' });
  }
});

// 各リソースのルート
app.use('/api/kajis', kajisRouter(pool));
app.use('/api/users', usersRouter(pool));
app.use('/api/kaji_records', kajiRecordsRouter(pool));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Backend server running on port ${PORT}`);
});