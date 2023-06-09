const express = require('express');
const router = express.Router();
const owners = require('../db/queries/owners')
const db = require('../configs/db.config');
const { route } = require('./sitters');

// router.get('/', async (req, res) => {
//   const ownerId = req.params.id;
//   owners.getAllOwners.then(data => {
//     res.json({owners: data})
//   })
// })

router.get('/:id/pets', async (req, res) => {

  const petOwnerId = req.params.id;
  owners.getPetNameByOwner(petOwnerId).then(data => {
    console.log(data);
    res.json({pet: data});
  })
});

router.get('/', async (req, res) => {
  const userId = req.user;
  owners.getOwnerIdFromUser(userId).then(data => {
    console.log(data)
    res.json({owner: data})
  })
})

module.exports = router;