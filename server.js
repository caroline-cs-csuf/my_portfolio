const express = require('express');
const app = express();
const PORT = 3000;

// Middleware to parse JSON bodies
app.use(express.json());

app.post('/send-email', (req, res) => {
    // Simulate sending email (replace with actual logic)
    // Print the body received from the client
    console.log('Received body:', req.body);

    // Extract name, email, and message from the request body
    const { name, email, message } = req.body;

    // Print name, email, and message
    console.log('Name:', name);
    console.log('Email:', email);
    console.log('Message:', message);
    console.log('Email sent successfully');

    res.sendStatus(200);
});

app.listen(PORT, () => {
    console.log(`Portofolio Mock email server is running on http://localhost:${PORT}`);
});


// app.get('/download-resume', (req, res) => {
//     // Simulate downloading resume file
//     const resumeFilePath = 'https://docs.google.com/document/d/1hQVuqa2BjCXL6UvfIfUallCC0C2Ua0oH5atKlKVp5AY/edit?usp=sharing'; // Replace with the actual path to your resume file
//     res.download(resumeFilePath, 'resume.pdf');
// });

// app.listen(PORT, () => {
//     console.log(`Portfolio Mock download server is running on http://localhost:${PORT}`);
// });
