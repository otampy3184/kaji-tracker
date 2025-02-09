-- 初期ユーザーテーブルの作成例
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  total_points INTEGER DEFAULT 0
);

-- 家事テーブルの作成例
CREATE TABLE IF NOT EXISTS kajis (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  points INTEGER NOT NULL,
  recorded_date TIMESTAMP
);