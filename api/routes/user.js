const router = require("express").Router();
const userCtrl = require("../controllers/user");
const authUser = require("../middleware/authUser");
const auth = require("../middleware/auth");
const multer = require("../middleware/multer-config");


router.post("/signup", authUser.checkPseudo, authUser.valid, userCtrl.signup);
router.post("/login", authUser.valid, userCtrl.login);
router.get("/accounts", auth, multer, userCtrl.getAllUsers);
router.put("/accounts/:id", auth, multer, userCtrl.updateAccount);
router.get("/accounts/:id", auth, multer, userCtrl.getAccount);
router.delete("/accounts/:id", auth, userCtrl.deleteAccount);


module.exports = router;