<template>
    <div class="Download">
       <md-tabs md-alignment="centered" md-sync-route>
        <md-tab id="tab-home" md-label="Home" to="/">
          <youtube video-id="-3JCESdFNyw" :player-height=800></youtube>
        </md-tab>
        <md-tab id="tab-download" md-label="Download" to="/download"></md-tab>
        <md-tab id="tab-about" md-label="About" to="/about" md-disabled></md-tab>
        <md-tab id="tab-contact" md-label="Contact" to="/contact" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-login" md-label="LOGIN" to="/login" md-disabled></md-tab>
        <md-tab md-alignment="right" id="tab-signup" md-label="SIGNUP" to="/signup" md-disabled></md-tab>
      </md-tabs>

      <div>
      <md-card>
        <md-card-media>
          <img src="../assets/osx-logo.png">
        </md-card-media>

        <md-card-header>
          <div class="md-title">OSX</div>
        </md-card-header>

        <md-card-actions>
          <a href="https://silverkey.app/artifacts/silverkey-latest-osx.zip"><md-button class="md-primary">Latest</md-button></a>
          <a href="https://silverkey.app/artifacts/silverkey-osx.zip"><md-button class="md-primary">Stable</md-button></a>
        </md-card-actions>
      </md-card>
      <md-card>

        <md-card-media>
          <img src="../assets/windows-logo.png" alt="Windows">
        </md-card-media>

        <md-card-header>
          <div class="md-title">Windows</div>
        </md-card-header>

        <md-card-actions>
          <md-button disabled>Latest</md-button>
          <md-button disabled>Stable</md-button>
        </md-card-actions>
      </md-card>
      <md-card>
        <md-card-media>
          <img src="../assets/linux-logo.png" alt="Linux">
        </md-card-media>
        <md-card-header>
          <div class="md-title">Linux</div>
        </md-card-header>

        <md-card-actions>
          <a href=https://silverkey.app/artifacts/silverkey-latest-linux.run><md-button class="md-primary">Latest</md-button></a>
          <a href=https://silverkey.app/artifacts/silverkey-linux.run><md-button class="md-primary">Stable</md-button></a>
        </md-card-actions>
      </md-card>

      </div>
    </div>
</template>

<style lang="scss" scoped>
  .md-card {
    min-width: 320px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
  .md-card-media {
    width: 120px;
    height: 120px;
    margin: 4px;
    display: inline-block;
    vertical-align: top;
  }
</style>

<script>
export default {
  name: 'Download',
  data () {
    return {
      msg: 'Silverkey app'
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
