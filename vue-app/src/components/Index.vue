<template>
    <div class="Index">
       <md-tabs md-alignment="centered" md-sync-route=True>
        <md-tab id="tab-home" md-label="Home" to="/">
          <youtube video-id="-3JCESdFNyw" :player-height=800></youtube>
        </md-tab>
        <md-tab id="tab-download" md-label="Download" to="/download"></md-tab>
        <md-tab id="tab-about" md-label="About" to="/about" md-disabled></md-tab>
        <md-tab id="tab-contact" md-label="Contact" to="/contact" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-login" md-label="LOGIN" to="/login" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-signup" md-label="SIGNUP" to="/signup" md-disabled></md-tab>
      </md-tabs>
    </div>
</template>

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

<!-- Add "scoped" attribute to limit CSS to this component only -->
