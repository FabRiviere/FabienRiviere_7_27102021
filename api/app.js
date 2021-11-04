const express = require("express");
const path = require("path");
const helmet = require("helmet");
const cors = require("cors");
require('dotenv').config();

// Routes
const userRoutes = require('./routes/user');
const postsRoutes = require('./routes/posts');

//db
const { sequelize } = require('./models/index');

const app = express();

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', process.env.AUTHORIZED_ORIGIN);
    res.setHeader('Access-Control-Allow-Headers','Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods','GET, POST, PUT, DELETE, PATCH, OPTIONS');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
  });

  app.use(cors());

// équivalent à bodyParser
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Sécurisation des headers
app.use(helmet());

// On indique le repertoire images pour servir nos images
app.use('./telechargement', express.static(path.join(__dirname, './telechargement')));

app.use('/api/users', userRoutes);
app.use('/api/posts', postsRoutes);

const dbTest = async function () {
    try {
      await sequelize.authenticate();
      console.log('Connexion à la base de données réussie. 😉');
    } catch (error) {
      console.error('Impossible de se connecter à la base de données 😩', error);
    }
  };
  dbTest();
  
  module.exports = app;