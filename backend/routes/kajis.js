const express = require('express');

module.exports = (pool) => {
  const router = express.Router();

  // 家事一覧取得エンドポイント
  router.get('/', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM kajis');
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: '家事データ取得エラー' });
    }
  });

  // 新規家事登録エンドポイント
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
      res.status(500).json({ error: '家事登録エラー' });
    }
  });

  return router;
};