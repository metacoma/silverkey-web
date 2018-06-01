<template>
    <div class="Index">
      <md-content>
       <md-tabs md-alignment="centered" md-sync-route=True>
        <md-tab id="tab-home" md-label="Homee" to="/" md-alignment-top-center>
          <youtube id="video" video-id="ca7T0bXptU8"></youtube>
        </md-tab>
        <md-tab id="tab-download" md-label="Download" to="/download"></md-tab>
        <md-tab id="tab-about" md-label="About" to="/about" md-disabled></md-tab>
        <md-tab id="tab-contact" md-label="Contact" to="/contact" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-login" md-label="LOGIN" to="/login" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-signup" md-label="SIGNUP" to="/signup" md-disabled></md-tab>
      </md-tabs>
      </md-content>
    </div>
</template>

<style>
  iframe {
    height: 480px !important;
  }
</style>


<style lang="scss" scoped>

  .md-content {
    height: 900px;
  }
  .md-tabs-content {
    height: 900px;
  }
  .md-tabs {
    height: 900px;
  }
</style>

<script>
export default {
  name: 'Index',
  data () {
    return {
      app: {
        name: 'Silverkey'
      }
    }
  }
}
</script>
