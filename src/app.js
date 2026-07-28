const express = require('express');
const healthRouter = require('./routes/health');

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.status(200).json({ message: 'Hello World' });
});

app.use('/api/health', healthRouter);

module.exports = app;
