const express = require('express');

module.exports = (pool) => {
  const router = express.Router();

  // GET /api/kajis - すべての家事データを取得
  router.get('/', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM kajis ORDER BY created_at DESC');
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to fetch kajis' });
    }
  });

  // POST /api/kajis - 新規家事データを登録
  router.post('/', async (req, res) => {
    const { title, content, points } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO kajis (title, content, points) VALUES ($1, $2, $3) RETURNING *',
        [title, content, points]
      );
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to create kaji' });
    }
  });

  return router;
};