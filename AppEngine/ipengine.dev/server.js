// [START app]
'use strict';

const express = require('express');
const uuid = require('uuid');
const app = express();

app.get('/', (req, res) => {
  res.status(200).send(`Hello, ${uuid()}!`);
});

// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`);
  console.log('Press Ctrl+C to quit.');
});
// [END app]