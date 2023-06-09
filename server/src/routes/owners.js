const express = require('express');
const router = express.Router();
const owners = require('../../db/queries/owners')
const db = require('../../configs/db.config');

router.get('/', async (req, res) => {
  const ownerId = req.params.id;
  owners.getAllOwners().then(data => {
    res.json({owners: data})
  })
})

router.get('/:id/pets', async (req, res) => {

  const petOwnerId = req.params.id;
  owners.getPetNameByOwner(petOwnerId).then(data => {
    console.log(data);
    res.json({pet: data});
  })
});

module.exports = router;