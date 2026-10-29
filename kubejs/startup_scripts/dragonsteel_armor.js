const DRAGONSTEEL_ELEMENTS = ["fire", "ice", "lightning"];

const DRAGONSTEEL_DURABILITY = {
  helmet: 1760,
  chestplate: 2560,
  leggings: 2400,
  boots: 2080,
};

ItemEvents.modification(event => {
  DRAGONSTEEL_ELEMENTS.forEach(element => {
    Object.keys(DRAGONSTEEL_DURABILITY).forEach(slot => {
      event.modify(`iceandfire:dragonsteel_${element}_${slot}`, item => {
        item.setMaxDamage(DRAGONSTEEL_DURABILITY[slot]);
      });
    });
  });
});
