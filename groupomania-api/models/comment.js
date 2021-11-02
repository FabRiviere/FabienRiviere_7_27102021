'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Comment extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

      models.User.belongsToMany(models.Post, {
        through: models.Comment,
        foreignKey: 'usersId',
        otherKey: 'postsId'
      });

      models.User.belongsToMany(models.User, {
        through: models.Comment,
        foreignKey: 'postsId',
        otherKey: 'usersId'
      });

      models.Comment.belongsTo(models.User, 
        { foreignKey: {
          allowNull: false
         
        }, onDelete:'CASCADE',
      }),
        models.Comment.belongsTo(models.Post, 
          { foreignKey: {
            allowNull: false,
               
          }, onDelete:'CASCADE',
        })
    }
    }
  };
  Comment.init({
    postsId: DataTypes.INTEGER,
    usersId: DataTypes.INTEGER,
    pseudo: DataTypes.STRING,
    message: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Comment',
  });
  return Comment;
};