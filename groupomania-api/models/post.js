'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Post extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here -relations dans la base de données Mysql
      models.Post.belongsTo(models.User, {
        foreignKey: {
          allowNull: false
        }, onDelete:'CASCADE',
      }),
      models.Post.hasMany(models.Like)

    }
  };
  Post.init({
    idUSERS: DataTypes.INTEGER,
    title: DataTypes.STRING,
    content: DataTypes.STRING,
    link: DataTypes.STRING,
    imageUrl: DataTypes.STRING,
    likes: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Post',
  });
  return Post;
};