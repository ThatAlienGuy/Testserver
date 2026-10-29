const $LexTool = Java.loadClass("net.minecraft.world.item.component.Tool");
const $LexToolRule = Java.loadClass("net.minecraft.world.item.component.Tool$Rule");
const $LexArrayList = Java.loadClass("java.util.ArrayList");
const $LexDataComponents = Java.loadClass("net.minecraft.core.component.DataComponents");

const LEX_VITAE_INCORRECT_TAG = "#minecraft:incorrect_for_netherite_tool";

ItemEvents.modification(event => {
  event.modify("neovitae:lex_vitae", item => {
    const tool = item.get($LexDataComponents.TOOL);
    if (tool == null) return;
    const rules = new $LexArrayList();
    tool.rules().forEach(rule => {
      if (rule.speed().isEmpty() && !rule.correctForDrops().orElse(true)) {
        rules.add($LexToolRule.deniesDrops(LEX_VITAE_INCORRECT_TAG));
      } else {
        rules.add(rule);
      }
    });
    item.setTool(new $LexTool(rules, tool.defaultMiningSpeed(), tool.damagePerBlock(), tool.canDestroyBlocksInCreative()));
  });
});
