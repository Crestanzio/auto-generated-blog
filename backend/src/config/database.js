import Database from 'better-sqlite3';
import path from 'path';
import fs from 'fs';

const rootDir    = process.cwd();
const dbFile     = path.join(rootDir, 'db.sqlite');

function getQueries() {
  const queriesPath = path.join(rootDir, 'src/config/queries');
  const queryFiles  = fs.readdirSync(queriesPath);
  const queries = {};
  
  queryFiles.forEach(file => {
    const name     = path.basename(file, path.extname(file));
    const filePath = path.join(queriesPath, file);
    const query    = fs.readFileSync(filePath, 'utf-8')
                       .replace(/\s+/g, ' ')
                       .replace(/\s*\)/g, ')')
                       .replace(/\(\s*/g, '(');

    queries[name] = query;
  });

  return { ...queries };
}

const db      = new Database(dbFile);
const queries = getQueries();

// Helper functions

function run(query, ...params) {
  const sql = db.prepare(query);
  return sql.run(...params);
}

function all(query, ...params) {
  const sql = db.prepare(query);
  return sql.all(...params);
}

function get(query, ...params) {
  const sql = db.prepare(query);
  return sql.get(...params);
}

export { db, queries, run, all, get };