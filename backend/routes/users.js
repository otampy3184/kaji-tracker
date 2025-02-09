const express = require('express');

module.exports = (pool) => {
  const router = express.Router();

  // ユーザー一覧取得エンドポイント
  router.get('/', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM users');
      res.json(result.rows);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'ユーザーデータ取得エラー' });
    }
  });

  // ここにユーザー登録やポイント更新のエンドポイントを追加可能

  return router;
};