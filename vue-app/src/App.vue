<template>
  <div class="page-container">
    <md-app md-waterfall  md-mode="fixed"  >
      <md-app-toolbar class="md-large md-dense md-primary">
        <div class="md-toolbar-row">
          <div class="md-toolbar-section-start">
            <span class="md-title">Silverkey app</span>
          </div>

          <div class="md-toolbar-section-end">
            <md-button class="md-icon-button">
              <md-icon>more_vert</md-icon>
            </md-button>
          </div>
        </div>

        <div class="md-toolbar-row">
          <md-tabs class="md-primary">
            <md-tab id="tab-home" md-label="Home"></md-tab>
            <md-tab id="tab-pages" md-label="Downloads"></md-tab>
          </md-tabs>
        </div>
      </md-app-toolbar>

      <md-app-content style="min-height: 100vh;">
        <iframe width="560" height="600" src="https://www.youtube.com/embed/ca7T0bXptU8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
      </md-app-content>
    </md-app>
  </div>
</template>

<style lang="scss" scoped>
  .md-app {
    max-height: 400px;
    border: 1px solid rgba(#000, .12);
  }

   // Demo purposes only
  .md-drawer {
    width: 230px;
    max-width: calc(100vw - 125px);
  }
</style>

<script>
export default {
  name: 'App',
  data: () => ({
    menuVisible: false
  })
}
</script>
