const express = require('express');

module.exports = (pool) => {
  const router = express.Router();

  // GET /api/kaji_records - 家事レコードの一覧取得（ユーザー名・家事タイトルもJOINして取得）
  router.get('/', async (req, res) => {
    try {
      const result = await pool.query(
        `SELECT kr.*, u.name as user_name, k.title as kaji_title 
         FROM kaji_records kr 
         JOIN users u ON kr.user_id = u.id 
         JOIN kajis k ON kr.kaji_id = k.id
         ORDER BY kr.performed_date DESC`
      );
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to fetch kaji records' });
    }
  });

  // POST /api/kaji_records - 新規家事レコードを登録
  router.post('/', async (req, res) => {
    const { user_id, kaji_id, performed_date } = req.body;
    try {
      const result = await pool.query(
        'INSERT INTO kaji_records (user_id, kaji_id, performed_date) VALUES ($1, $2, $3) RETURNING *',
        [user_id, kaji_id, performed_date]
      );
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to create kaji record' });
    }
  });

  return router;
};