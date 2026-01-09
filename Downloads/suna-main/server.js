const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 3000;

// Serve static files from current directory
app.use(express.static('.'));

// Serve React files
app.use('/src', express.static(path.join(__dirname, 'src')));

// Handle React routing
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(port, () => {
  console.log(`🚀 Kortix AI server running on port ${port}`);
  console.log(`📱 Open http://localhost:${port} in your browser`);
});
