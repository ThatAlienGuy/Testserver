const $JeiInternal = Java.loadClass('mezz.jei.common.Internal')
const $ProductiveBeesJeiPlugin = Java.loadClass('cy.jdkdigital.productivebees.compat.jei.ProductiveBeesJeiPlugin')
const $Minecraft = Java.loadClass('net.minecraft.client.Minecraft')

RecipeViewerEvents.removeRecipes(event => {
    $Minecraft.getInstance().schedule(() => {
        const runtime = $JeiInternal.getOptionalJeiRuntime().orElse(null)
        if (!runtime) return

        const recipeManager = runtime.getRecipeManager()
        const type = $ProductiveBeesJeiPlugin.BEE_FLOWERING_TYPE
        const hidden = recipeManager.createRecipeLookup(type).get()
            .filter(recipe => recipe.bee() && String(recipe.bee().getBeeType()) == 'productivebees:amber')
            .toList()

        if (!hidden.isEmpty()) recipeManager.hideRecipes(type, hidden)
    })
})
