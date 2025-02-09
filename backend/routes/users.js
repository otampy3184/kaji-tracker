const express = require('express');

module.exports = (pool) => {
  const router = express.Router();

  // GET /api/users - すべてのユーザーを取得
  router.get('/', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM users ORDER BY created_at DESC');
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to fetch users' });
    }
  });

  // POST /api/users - 新規ユーザーを登録
  router.post('/', async (req, res) => {
    const { name } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO users (name) VALUES ($1) RETURNING *',
        [name]
      );
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to create user' });
    }
  });

  return router;
};