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
            <md-tab id="tab-download" md-label="Downloads"></md-tab>
          </md-tabs>
        </div>
      </md-app-toolbar>

      <md-app-content style="min-height: 1000vh;">
<!--
        <youtube video-id="-3JCESdFNyw" :player-height=800></youtube>
-->
      </md-app-content>
    </md-app>
  </div>
</template>

<style lang="scss" scoped>
  .md-app {
    max-height: 1200px;
    border: 1px solid rgba(#000, .12);
  }

   // Demo purposes only
</style>

<script>
export default {
  name: 'App',
  data: () => ({
    menuVisible: false
  })
}
</script>
