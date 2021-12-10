const express = require('express');
const path = require('path');

const helmet = require('helmet');
const cors = require('cors');
require('dotenv').config();

// Routes
const userRoutes = require('./routes/user');
const postsRoutes = require('./routes/posts');

//db
const { sequelize } = require('./models/index');

const app = express();

// équivalent à bodyParser
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(cors());
// Sécurisation des headers
app.use(helmet());

// On indique le repertoire images pour servir nos images
app.use('/api/upload', express.static(path.join(__dirname, 'upload')));
app.use('/api/users', userRoutes);
app.use('/api/posts', postsRoutes);

const dbTest = async function() {
	try {
		await sequelize.authenticate();
		console.log('Connexion à la base de données réussie. 😉');
	} catch (error) {
		console.error('Impossible de se connecter à la base de données 😩', error);
	}
};
dbTest();

module.exports = app;
