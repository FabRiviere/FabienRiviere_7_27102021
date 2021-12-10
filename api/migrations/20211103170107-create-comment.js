'use strict';
module.exports = {
	up: async (queryInterface, Sequelize) => {
		await queryInterface.createTable('Comments', {
			id: {
				allowNull: false,
				autoIncrement: true,
				primaryKey: true,
				type: Sequelize.INTEGER
			},
			message: {
				allowNull: false,
				type: Sequelize.TEXT
			},
			pseudo: {
				allowNull: false,
				type: Sequelize.STRING
			},
			UserId: {
				allowNull: false,
				type: Sequelize.INTEGER,
				references: {
					model: 'User',
					key: 'id'
				}
			},
			PostId: {
				allowNull: false,
				type: Sequelize.INTEGER,
				references: {
					model: 'Post',
					key: 'id'
				}
			},
			createdAt: {
				allowNull: false,
				type: Sequelize.DATE
			},
			updatedAt: {
				allowNull: false,
				type: Sequelize.DATE
			}
		});
	},
	down: async (queryInterface, Sequelize) => {
		await queryInterface.dropTable('Comments');
	}
};
